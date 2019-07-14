async function mapInit(lons, lats) {

  // 36行目~46行目は、fetchでPinを取得する方のやり方。
  let json = await fetch('http://localhost:3000/maps/1/pins.json')
    .then(function(response) {
      return response.json();
    })
    .then(function(myJson) {
      return myJson;
    });

  map = L.map('mapid').setView([lons[0], lats[0]], 5);

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

      let image_sources = ['/single_point_gps_navigation_pin_icon-icons.com_59903.svg', '/目的地アイコン2.svg', '/位置情報の無料アイコン2.svg', '/人物アイコン　チーム.svg']
      let textContents  = ['New Pin', 'New Pin', 'View Pins', 'Friends']

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
    // L.marker([lons[i], lats[i]],{icon: L.divIcon({className: 'marker'})}).addTo(map)
    .bindPopup(`This is <br><h3>${json[i].title}</h3>`)
    .openPopup()
  }

  let pinMarker = L.marker([20, 20], {icon: pinIcon, draggable:true}).addTo(map);
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


  // テスト用のPin
  let sightSeeing = [
    { country: 'USA', name: 'Grand Canyon National Park', lonlat: [36.0922146, -113.4035967]},
    { country: '日本', name: '富士山', lonlat: [35.3606422,138.7186086] },
    { country: '中國', name: '慕田峪长城', lonlat: [40.4319118,116.5681862]},
    { country: 'France', name: 'Tour Eiffel', lonlat: [48.8583701, 2.2922926]},
  ];

  // JavaScriptでPOSTする
  let button = document.querySelector('.pin-icon');
  button.addEventListener('click', async () => {
    for (let i = 0; i < sightSeeing.length; i++) {
      L.marker(sightSeeing[i].lonlat).addTo(map)
      .bindPopup(`This is <br><h3>${sightSeeing[i].name}</h3>in ${sightSeeing[i].country}`)
      .openPopup();

      if(i === 0) {
        console.log(i);
        
        // CSRF用のトークン
        const token = document.getElementsByName('csrf-token').item(0).content;

        // ボディを作る
        const formData = new FormData();
        formData.append('authenticity_token', token);
        formData.append('pin[title]', `${sightSeeing[i].name}`);
        formData.append('pin[description]', `${sightSeeing[i].country}の世界遺産ですよ。`);
        formData.append('pin[lonlat]', `${sightSeeing[i].lonlat[0]} ${sightSeeing[i].lonlat[1]}`);
        
        const postRequest = await fetch(location.href + '/pins', {
          method: "POST",
          body: formData
        });
        
        if (postRequest.status === 200) {
          console.log('成功');
        } else {
          console.log('失敗');
          console.log(postRequest.status);
        }
      }
    }
  });

});






// document.addEventListener("DOMContentLoaded", () => {
//   const form = document.querySelector('form');
//   const messages = document.querySelector('#messages');

//   form.onsubmit = async (e) => {
//     e.preventDefault();
//     const formData = new FormData();
//     const message = form.message.value;
//     if (message === '') return;
//     formData.append('message', message);
//     const row = await fetch(location.href, {
//       method: "post",
//       body: formData
//     });
    
//     if (row.status === 200) {
//       const newMessage = document.createTextNode(message);
//       const newMessageElement = document.createElement("li");
//       newMessageElement.appendChild(newMessage);
//       messages.appendChild(newMessageElement);
//     }
//   };
// });


// // CSRFトークン
// function testRequest(){
//   var xhr = new XMLHttpRequest();
//   xhr.onreadystatechange = function() {
//     if (this.readyState==4 && this.status==200) {
//       location.href = '/';
//     }
//   };
//   var token = document.getElementsByName('csrf-token').item(0).content; // 追加
//   xhr.responseType = 'json';
//   xhr.open('POST', '/something.json', true);
//   xhr.setRequestHeader('X-CSRF-Token', token); // 追加
//   xhr.send();
// }