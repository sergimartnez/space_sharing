$(document).ready(function(){
  var map;
  function initialize() {
    var latlng = new google.maps.LatLng(gon.lat, gon.long);
    var mapOptions = {
      zoom: 12,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById("map"), mapOptions);
    marker = new google.maps.Marker({
      possition: latlng,
      title: "test"
    });
    marker.setMap(map);
  }
  initialize();
});