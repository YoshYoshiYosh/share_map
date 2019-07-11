function sampleMap(lons, lats) {

    let map = L.map('mapid').setView([lons[0], lats[0]], 3);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);
    
    for (let i = 0; i < lons.length; i++) {
      L.marker([lons[i], lats[i]]).addTo(map)
      .bindPopup('A pretty CSS3 popup.<br> Easily customizable.')
      .openPopup();
    }
}

document.addEventListener("DOMContentLoaded", function(){

  let lonsRaw = document.querySelectorAll(".lon")
  let latsRaw = document.querySelectorAll(".lat")  
  
  let pinsNumber = lonsRaw.length;
  let lons = [];
  let lats = [];

  for (let i = 0; i < pinsNumber; i++) {
    lons.push(lonsRaw[i].textContent);
    lats.push(latsRaw[i].textContent);
  }

  sampleMap(lons, lats);

});