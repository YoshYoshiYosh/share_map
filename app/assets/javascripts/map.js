// function sampleMap(lons, lats) {

//     let map = L.map('mapid').setView([lons[0], lats[0]], 3);

//     L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
//         attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
//     }).addTo(map);
    
//     for (let i = 0; i < lons.length; i++) {
//       L.marker([lons[i], lats[i]]).addTo(map)
//       .bindPopup('A pretty CSS3 popup.<br> Easily customizable.')
//       .openPopup();
//     }
// }

// document.addEventListener("DOMContentLoaded", function(){

//   let lonsRaw = document.querySelectorAll(".lon")
//   let latsRaw = document.querySelectorAll(".lat")  
  
//   let pinsNumber = lonsRaw.length;
//   let lons = [];
//   let lats = [];

//   for (let i = 0; i < pinsNumber; i++) {
//     lons.push(lonsRaw[i].textContent);
//     lats.push(latsRaw[i].textContent);
//   }

//   sampleMap(lons, lats);

// });

async function mapInit(lons, lats) {

  // 36行目~46行目は、fetchでPinを取得する方のやり方。lon
  let json = await fetch('http://localhost:3000/maps/1/pins.json')
    .then(function(response) {
      return response.json();
    })
    .then(function(myJson) {
      return myJson;
    });

  console.log(json[0]);
  console.log(json[1]);

  let map = L.map('mapid').setView([lons[0], lats[0]], 3);

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
        var img = L.DomUtil.create('img');

        img.src = '/-pin-drop_90711.svg';
        img.style.width = '5vw';

        return img;
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
    .bindPopup(`This is ${json[i].title}.`)
    .openPopup();
  }

  let pinMarker = L.marker([20, 20], {icon: pinIcon}).addTo(map);
  pinMarker.bindPopup('my pin')
  .openPopup();
  
};

document.addEventListener("DOMContentLoaded", function(){

  let lonsRaw = document.querySelectorAll(".lon");
  let latsRaw = document.querySelectorAll(".lat") ; 
  
  let pinsNumber = lonsRaw.length;
  let lons = [];
  let lats = [];

  for (let i = 0; i < pinsNumber; i++) {
    lons.push(lonsRaw[i].textContent);
    lats.push(latsRaw[i].textContent);
  };

  mapInit(lons, lats);

});