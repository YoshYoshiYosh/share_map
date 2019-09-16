function escapeHtml (string) {
  return string.replace(/[&'`"<>]/g, function(match) {
    return {
      '&': '&amp;',
      "'": '&#x27;',
      '`': '&#x60;',
      '"': '&quot;',
      '<': '&lt;',
      '>': '&gt;',
    }[match]
  });
}

function showEditButton(e) {
  e.target.firstElementChild.classList.add('shown');
}

function hideEditButton(e) {
  e.target.firstElementChild.classList.remove('shown');
}

function setLonlat(latlon) {
  return new Promise(resolve => {
    navigator.geolocation.getCurrentPosition(pos => {
      resolve([pos.coords.latitude, pos.coords.longitude])
    })
  }).then(response => {
    latlon.lat = response[0]
    latlon.lon = response[1]
  })
}

// この関数が実行される前に、なぜか呼び出し元の console.log(`lat:${latlon.lat}, lon:${latlon.lon}`) が実行されてしまう
// function secondSetLonlat(latlon) {
//     navigator.geolocation.getCurrentPosition(pos => {
//       latlon.lat = pos.coords.latitude
//       latlon.lon = pos.coords.longitude
//   })
// }

function adjustMarginWhenPinCreated() {
  successFlash = document.querySelector('.alert-success') || ''
  if (successFlash) {
    return true
  }
}

async function mapInit(location) {

  let isAuthor = !!document.getElementById('is-author')

  let storedPins = await fetch(`${location}/pins.json`)
    .then(function(response) {
      return response.json();
    })

  if(storedPins.length === 0) {
    storedPins.push({ title: 'default', lonlat: { x: 51.476853, y: -0.0005002 } })
  }

  map = L.map('mapid').setView([storedPins[0].lonlat.x, storedPins[0].lonlat.y], 5);

  let pinIcon = L.icon({
    iconUrl: '/pin_icon.png',
    iconSize: [30, 30],
    iconAnchor: [15, 30],
    popupAnchor: [0, -40]
  })

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);

  L.Control.Watermark = L.Control.extend({
    onAdd: function(map) {

      let outerDiv = L.DomUtil.create('div', "map-button-container d-flex");
      
      outerDiv.style.backgroundColor = 'rgba(255,255,255,.5)';
      outerDiv.style.padding = '20px';
      outerDiv.style.margin = '0';
      outerDiv.style.zIndex = '5';

      let imageAndTextOfButton = [
        { imgSrc: '/single_pin_icon.svg', text: 'New Pin' },
        { imgSrc: '/destination_icon.svg', text: 'New Pin' },
        { imgSrc: '/human_pin_icon.svg', text: 'View Pins' }
      ]
      
      if (isAuthor) {
        imageAndTextOfButton.push({ imgSrc: '/teams_icon.svg', text: 'Add Member' })
      }

      for (let i = 0; i < imageAndTextOfButton.length; i++) {
        let div = L.DomUtil.create('div', "map-button-container__box", outerDiv);
        let img = L.DomUtil.create('img', "pin-icon", div);   
        
        switch(i) {
          case 0: {
            img.classList.add("add-pin");
            img.setAttribute('data-toggle', 'modal');
            img.setAttribute('data-target', '#exampleModalCenter')
            break;
          }

          // case 1:は、現在地を取得するピン作成？
          
          case 2: {
            img.classList.add("add-menber-form");
            break;
          }

          case 3: {
            img.classList.add("add-member");
            break;
          }
        }

        let smallText = L.DomUtil.create('p', "small-text", div);

        smallText.textContent = imageAndTextOfButton[i].text
        img.src = imageAndTextOfButton[i].imgSrc

      };
      return outerDiv;
    },

    onRemove: function(map) {
        // Nothing to do here
    }
  });
  
  L.control.watermark = function(opts) {
      return new L.Control.Watermark(opts);
  };
  
  L.control.watermark({ position: 'topright' }).addTo(map);
  
  for (let i = 0; i < storedPins.length; i++) {
    if (storedPins[i].image === undefined) {
      L.marker([storedPins[i].lonlat.x, storedPins[i].lonlat.y]).addTo(map)
      .bindPopup(`This is <br><h3>${escapeHtml(storedPins[i].title)}</h3>`)
      .openPopup()      
    } else {
      L.marker([storedPins[i].lonlat.x, storedPins[i].lonlat.y]).addTo(map)
      .bindPopup(`This is <br><h3>${escapeHtml(storedPins[i].title)}</h3><img class="pin-image" src=${storedPins[i].image}>`)
      .openPopup()
    }
  }

};

document.addEventListener("turbolinks:load", async function(){
  console.log('読み込まれました');
  
  if (/maps\/\d\/admin$/.test(location.href)) {
    let showEditButtonAtAdminPages = [
                                      document.querySelector('.manage-title'),
                                      document.querySelector('.manage-description'),
                                      document.querySelector('.manage-users'),
                                      document.querySelector('.manage-pins')
                                    ];
  
    showEditButtonAtAdminPages.forEach((element) => {
      element.addEventListener('pointerover', showEditButton, false);
      element.addEventListener('pointerleave', hideEditButton, false);
    });
  }

  if(/maps\/\d\/?$/.test(location.href)) {

    if (adjustMarginWhenPinCreated()) {
      document.querySelector('.breadcrumb').classList.replace('mt-0', 'flash-fix-margin')
    }
    
    await mapInit(location.href);

    let addMemberButton = document.querySelector('.add-member');
    addMemberButton.addEventListener('click', () => {
      open(`${location.href}/authorized_maps/new`);
    })

    let addPinButton = document.querySelector('.add-pin');
    addPinButton.addEventListener('click', async () => {
      let latlon = {lat: 0, lon: 0}
      await setLonlat(latlon);
      // await secondSetLonlat(latlon);
      console.log(`lat:${latlon.lat}, lon:${latlon.lon}`)

      let submitButton = document.getElementsByName('commit')[0]
      submitButton.addEventListener('click', async (event) => {

        console.log("送信ボタンがクリックされました")
        
        event.preventDefault();
        
        // CSRF用のトークン
        const token = document.getElementsByName('csrf-token').item(0).content;

        let inputTitle       = document.getElementById("pin_title").value;
        let inputDescription = document.getElementById("pin_description").value;
        let inputLonlat      = `${latlon.lat} ${latlon.lon}`;

        // ボディを作る
        const formData = new FormData();
        formData.append('authenticity_token', token);
        formData.append('pin[title]', inputTitle);
        formData.append('pin[description]', inputDescription);
        formData.append('pin[lonlat]', inputLonlat);

        const postRequest = await fetch(location.href + '/pins', {
          method: "POST",
          body: formData
        });

        if (postRequest.status === 200) {
          console.log('成功');
          location.reload()
        } else {
          console.log('失敗');
          console.log(postRequest.status);
        }
        
      }
      )
    })
  }

});