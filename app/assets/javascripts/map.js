function noroma() {
  return new Promise(resolve => {
    setTimeout(() => {
      resolve(console.log("5秒経過"))
    }, 5000)
  })
}

function sleep(second) {
  second *= 1000;
  time_origin = new Date().getTime();
  time_now    = new Date().getTime();
  while( time_now < time_origin + second ) {
    console.log(`${(time_now - time_origin) / 1000 }秒経過..`)
    time_now = new Date().getTime();
  }
  return;
}

async function scrollMonster() {
  const x = window.scrollX;
  const y = window.scrollY;
  // await noroma();
  // await sleep(10);
  return {x, y}
}

// function sampleMap() {
//   let map = L.map('mapid').setView([51.505, -0.09], 13);

//   L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
//       attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
//   }).addTo(map);
  
//   L.marker([51.5, -0.09]).addTo(map)
//       .bindPopup('A pretty CSS3 popup.<br> Easily customizable.')
//       .openPopup();
// }

// function sampleMap(lons, lats) {
//   // 引数をlons, latsにして、for文を実行する
//   for (let i = 0; i < lons.length; i++) {

//     let map = L.map('mapid').setView([lons[i], lats[i]], 1);

//     L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
//         attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
//     }).addTo(map);
    
//     L.marker([lons[i], lats[i]]).addTo(map)
//         .bindPopup('A pretty CSS3 popup.<br> Easily customizable.')
//         .openPopup();
//   }
// }



function sampleMap(lons, lats) {
  // 引数をlons, latsにして、for文を実行する

    let map = L.map('mapid').setView([lons[0], lats[0]], 1);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);
    
    for (let i = 0; i < lons.length; i++) {
      L.marker([lons[i], lats[i]]).addTo(map)
      .bindPopup('A pretty CSS3 popup.<br> Easily customizable.')
      .openPopup();
    }
}



const option = {
  once: true
};

document.addEventListener("DOMContentLoaded", function(){

  let lonsRaw = document.querySelectorAll(".lon")
  let latsRaw = document.querySelectorAll(".lat")  
  
  let pinsNumber = lonsRaw.length;
  let lons = [];
  let lats = [];

  for (var i = 0; i < pinsNumber; i++) {
    lons.push(lonsRaw[i].textContent);
    lats.push(latsRaw[i].textContent);
  }

  sampleMap(lons, lats);

  var button = document.getElementById("tap-me");
  button.addEventListener("click", async () => {
    alert('clicked.')
    let {x, y} = await scrollMonster();
    console.log(x, y);
  }, option);
});