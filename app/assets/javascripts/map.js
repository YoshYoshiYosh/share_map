async function mapInit(lons, lats) {

  // 36行目~46行目は、fetchでPinを取得する方のやり方。
  let json = await fetch('http://localhost:3000/maps/1/pins.json')
    .then(function(response) {
      return response.json();
    })
    .then(function(myJson) {
      return myJson;
    });

  let map = L.map('mapid').setView([lons[0], lats[0]], 5);

  let pinIcon = L.icon({
    iconUrl: '/pin_icon.png',
    iconSize: [30, 30],
    iconAnchor: [15, 30],
    popupAnchor: [0, -40]
  })

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);

  // 最終的には、「画像をクリックするとPinを新規作成する」というようにしたい
  L.Control.Watermark = L.Control.extend({
    onAdd: function(map) {

      // 一番外の枠
      let outer_div = L.DomUtil.create('div', "map-button-container d-flex");
      outer_div.style.backgroundColor = 'rgba(255,255,255,.5)';
      outer_div.style.padding = '20px';
      outer_div.style.margin = '0';
      outer_div.style.zIndex = '5';

      let image_sources = ['/single_point_gps_navigation_pin_icon-icons.com_59903.svg', '/目的地アイコン2.svg', '/位置情報の無料アイコン2.svg', '/位置情報の無料アイコン2.svg']
      let textContents  = ['New Pin', 'New Pin', 'View Pins', 'View Pins']

      for(let i = 0; i < 4; i++) {
        let div = L.DomUtil.create('div', "map-button-container__box", outer_div);
        let img = L.DomUtil.create('img', "pin-icon", div);
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

  for (let i = 0; i < lons.length; i++) {
    L.marker([lons[i], lats[i]]).addTo(map)
    .bindPopup(`This is <br><h3>${json[i].title}</h3>`)
    .openPopup()
  }

  let pinMarker = L.marker([20, 20], {icon: pinIcon}).addTo(map);
  pinMarker.bindPopup('my pin')
  .openPopup();
    
};

document.addEventListener("DOMContentLoaded", async function(){

  let lonsRaw = document.querySelectorAll(".lon");
  let latsRaw = document.querySelectorAll(".lat") ; 
  
  let pinsNumber = lonsRaw.length;
  let lons = [];
  let lats = [];

  for (let i = 0; i < pinsNumber; i++) {
    lons.push(lonsRaw[i].textContent);
    lats.push(latsRaw[i].textContent);
  };

  await mapInit(lons, lats);

  let testElement = document.querySelector('.pin-icon')

  let jsonElement = testElement.addEventListener('click', () => {
  fetch('http://localhost:3000/maps/1/pins.json')
    .then((response) => {
      return response.json();
    })
  });


});