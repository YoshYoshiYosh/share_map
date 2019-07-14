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

function 

const option = {
  once: true
};


document.addEventListener("DOMContentLoaded", function(){

  let map = L.map('mapid').setView([51.505, -0.09], 13);

  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map);
  
  L.marker([51.5, -0.09]).addTo(map)
      .bindPopup('A pretty CSS3 popup.<br> Easily customizable.')
      .openPopup();

  var button = document.getElementById("tap-me");
  button.addEventListener("click", async () => {
    alert('clicked.')
    let {x, y} = await scrollMonster();
    console.log(x, y);
  }, option);
});