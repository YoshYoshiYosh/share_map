function escapeHtml(string) {
  return string.replace(/[&'`"<>]/g, (match) => ({
    '&': '&amp;',
    "'": '&#x27;',
    '`': '&#x60;',
    '"': '&quot;',
    '<': '&lt;',
    '>': '&gt;',
  }[match]));
}

function showEditButton(e) {
  e.target.firstElementChild.classList.add('shown');
}

function hideEditButton(e) {
  e.target.firstElementChild.classList.remove('shown');
}

function setLonlat() {
  return new Promise((resolve, reject) => {
    navigator.geolocation.getCurrentPosition((pos) => {
      resolve({ lat: pos.coords.latitude, lon: pos.coords.longitude });
    },
    (err) => {
      reject(err);
    },
    {
      enableHighAccuracy: true,
    });
  });
}

function adjustMarginWhenPinCreated() {
  const successFlash = document.querySelector('.alert-success') || '';
  if (successFlash) {
    return true;
  }
  return false;
}

async function mapInit(location) {
  const isAuthor = !!document.getElementById('is-author');

  const storedPins = await fetch(`${location}/pins.json`)
    .then((response) => response.json());

  if (storedPins.length === 0) {
    storedPins.push({ title: 'default', lonlat: { x: 51.476853, y: -0.0005002 } });
  }

  const map = L.map('mapid', {minZoom: 5}).setView([storedPins[0].lonlat.x, storedPins[0].lonlat.y], 5);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
  }).addTo(map);

  L.Control.Watermark = L.Control.extend({
    onAdd(map) {
      const outerDiv = L.DomUtil.create('div', 'map-button-container d-flex');

      outerDiv.style.backgroundColor = 'rgba(255,255,255,.5)';
      outerDiv.style.padding = '20px';
      outerDiv.style.margin = '0';
      outerDiv.style.zIndex = '5';

      const imageAndTextOfButton = [
        { imgSrc: '/single_pin_icon.svg', text: 'New Pin' },
        { imgSrc: '/human_pin_icon.svg', text: 'View Pins' },
      ];

      if (isAuthor) {
        imageAndTextOfButton.push({ imgSrc: '/teams_icon.svg', text: 'Add Member' });
      }

      for (let i = 0; i < imageAndTextOfButton.length; i++) {
        const div = L.DomUtil.create('div', 'map-button-container__box', outerDiv);
        const img = L.DomUtil.create('img', 'pin-icon', div);

        switch (i) {
          case 0: {
            img.classList.add('add-pin');
            img.setAttribute('data-toggle', 'modal');
            img.setAttribute('data-target', '#exampleModalCenter');
            break;
          }

          case 1: {
            img.classList.add('view-pins');
            break;
          }

          case 2: {
            img.classList.add('add-member');
            img.classList.add('mb-0');
            break;
          }
        }

        const smallText = L.DomUtil.create('p', 'small-text', div);

        smallText.textContent = imageAndTextOfButton[i].text;
        img.src = imageAndTextOfButton[i].imgSrc;
      }
      return outerDiv;
    },

    onRemove(map) {
      // Nothing to do here
    },
  });

  L.control.watermark = function (opts) {
    return new L.Control.Watermark(opts);
  };

  L.control.watermark({ position: 'topright' }).addTo(map);

  for (let i = 0; i < storedPins.length; i++) {
    if (storedPins[i].image === undefined) {
      L.marker([storedPins[i].lonlat.x, storedPins[i].lonlat.y]).addTo(map)
        .bindPopup(`This is <br><h3>${escapeHtml(storedPins[i].title)}</h3>`)
        .openPopup();
    } else {
      L.marker([storedPins[i].lonlat.x, storedPins[i].lonlat.y]).addTo(map)
        .bindPopup(`This is <br><h3>${escapeHtml(storedPins[i].title)}</h3><img class="pin-image" src=${storedPins[i].image}>`)
        .openPopup();
    }
  }
}

document.addEventListener('turbolinks:load', async () => {
  console.log('読み込まれました');

  if (/maps\/\d\/admin\/?$/.test(location.href)) {
    const showEditButtonAtAdminPages = [
      document.querySelector('.manage-title'),
      document.querySelector('.manage-description'),
      document.querySelector('.manage-users'),
      document.querySelector('.manage-pins'),
    ];

    showEditButtonAtAdminPages.forEach((element) => {
      element.addEventListener('pointerover', showEditButton, false);
      element.addEventListener('pointerleave', hideEditButton, false);
    });
  }

  if (/maps\/\d\/?$/.test(location.href)) {
    if (adjustMarginWhenPinCreated()) {
      document.querySelector('.breadcrumb').classList.replace('mt-0', 'flash-fix-margin');
    }

    await mapInit(location.href);



    const viewPinsButton = document.querySelector('.view-pins');
    viewPinsButton.addEventListener('click', () => {
      open(`${location.href}/pins`, '_self');
    })
    
    const addPinButton = document.querySelector('.add-pin');
    addPinButton.addEventListener('click', async () => {
      const latlon = await setLonlat();
      console.log(`lat:${latlon.lat}, lon:${latlon.lon}`);

      const submitButton = document.getElementsByName('commit')[0];
      submitButton.addEventListener('click', async (event) => {
        console.log('送信ボタンがクリックされました');

        event.preventDefault();

        const token = document.getElementsByName('csrf-token').item(0).content;

        const inputTitle = document.getElementById('pin_title').value;
        const inputDescription = document.getElementById('pin_description').value;
        const inputLonlat = `${latlon.lat} ${latlon.lon}`;

        const formData = new FormData();
        formData.append('authenticity_token', token);
        formData.append('pin[title]', inputTitle);
        formData.append('pin[description]', inputDescription);
        formData.append('pin[lonlat]', inputLonlat);

        const postRequest = await fetch(`${location.href}/pins`, {
          method: 'POST',
          body: formData,
          redirect: 'manual',
        });

        if (postRequest.status === 201) {
          console.log('成功');
          location.reload();
        } else {
          console.log('失敗');
          console.log(postRequest.status);
          $('.alert-danger').show();
        }
      });
    });

    if (document.getElementById('is-author')) {
      const addMemberButton = document.querySelector('.add-member');
      addMemberButton.addEventListener('click', () => {
        open(`${location.href}/authorized_maps/new`, '_self');
      });
    };

  }
});
