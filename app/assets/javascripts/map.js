function escape_html (string) {
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

async function mapInit() {

  let json = await fetch('http://localhost:3000/maps/1/pins.json')
    .then(function(response) {
      return response.json();
    })

  if(json.length === 0) {
    json.push({ title: 'default' })
  }

  map = L.map('mapid').setView([json[0].lonlat.x, json[0].lonlat.y], 5);

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

      // 一番外の枠
      let outer_div = L.DomUtil.create('div', "map-button-container d-flex");
      outer_div.style.backgroundColor = 'rgba(255,255,255,.5)';
      outer_div.style.padding = '20px';
      outer_div.style.margin = '0';
      outer_div.style.zIndex = '5';

      let image_sources = ['/single_point_gps_navigation_pin_icon-icons.com_59903.svg', '/目的地アイコン2.svg', '/位置情報の無料アイコン2.svg', '/人物アイコン　チーム.svg']
      let textContents  = ['New Pin', 'New Pin', 'View Pins', 'Add Member']

      for(let i = 0; i < 4; i++) {
        let div = L.DomUtil.create('div', "map-button-container__box", outer_div);
        let img = L.DomUtil.create('img', "pin-icon", div);   
        
        switch(i) {
          case 0: {
            img.classList.add("add-pin");
            img.setAttribute('data-toggle', 'modal');
            img.setAttribute('data-target', '#exampleModalCenter')
            break;
          }
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
        img.src = image_sources[i]
        smallText.textContent = textContents[i]
      };
      return outer_div;
    },

    onRemove: function(map) {
        // Nothing to do here
    }
  });
  
  L.control.watermark = function(opts) {
      return new L.Control.Watermark(opts);
  };
  
  L.control.watermark({ position: 'topright' }).addTo(map);
  
  for (let i = 0; i < json.length; i++) {
    if (json[i].image === undefined) {
      L.marker([json[i].lonlat.x, json[i].lonlat.y]).addTo(map)
      .bindPopup(`This is <br><h3>${escape_html(json[i].title)}</h3>`)
      .openPopup()      
    } else {
      L.marker([json[i].lonlat.x, json[i].lonlat.y]).addTo(map)
      .bindPopup(`This is <br><h3>${escape_html(json[i].title)}</h3><img class="pin-image" src=${json[i].image}>`)
      .openPopup()
    }
  }

};

document.addEventListener("turbolinks:load", async function(){
  console.log('読み込まれました');
  
  if (/maps\/\d\/admin$/.test(location.href)) {
    let showEditButtonAtAdminPages = [document.querySelector('.manage-title'), document.querySelector('.manage-description'), document.querySelector('.manage-users'), document.querySelector('.manage-pins')];
  
    showEditButtonAtAdminPages.forEach((element) => {
      element.addEventListener('pointerover', showEditButton, false);
      element.addEventListener('pointerleave', hideEditButton, false);
    });
  }

  if(/maps\/\d\/?$/.test(location.href)) {

    await mapInit();

    // テスト用のPin
    let sightSeeing = [
      { country: 'USA', name: 'Grand Canyon National Park', lonlat: [36.0922146, -113.4035967]},
      { country: '日本', name: '富士山', lonlat: [35.3606422,138.7186086] },
      { country: '中國', name: '慕田峪长城', lonlat: [40.4319118,116.5681862]},
      { country: 'France', name: 'Tour Eiffel', lonlat: [48.8583701, 2.2922926]},
    ];

    // JavaScriptでPOSTする
    // let addPinButton = document.querySelector('.add-pin');
    // addPinButton.addEventListener('click', async () => {
    //   for (let i = 0; i < sightSeeing.length; i++) {
    //       // CSRF用のトークン
    //       const token = document.getElementsByName('csrf-token').item(0).content;

    //       // ボディを作る
    //       const formData = new FormData();

    //       // 成功する
    //       formData.append('authenticity_token', token);
    //       formData.append('pin[title]', `${sightSeeing[i].name}`);
    //       formData.append('pin[description]', `${sightSeeing[i].country}の世界遺産ですよ。`);
    //       formData.append('pin[lonlat]', `${sightSeeing[i].lonlat[0]} ${sightSeeing[i].lonlat[1]}`);
    //       // 

    //       const postRequest = await fetch(location.href + '/pins.json', {
    //         method: "POST",
    //         body: formData
    //       });

    //       console.log(postRequest);

    //       if (postRequest.status === 200) {
    //         console.log('成功');
    //         ここで作成したマーカーを追加する処理を書く
    //       } else {
    //         console.log('失敗');
    //       }
    //   }

    // });

    let addMemberButton = document.querySelector('.add-member');
    addMemberButton.addEventListener('click', async () => {
      open('http://localhost:3000/maps/1/authorized_maps/new', '_blank');
    })
  }

});