$(document).ready(function(){
  function initMap() {
    
    var locations = gon.marker_locations
    var mapProp= {
      center:new google.maps.LatLng(gon.coords_req[0], gon.coords_req[1]),
      zoom:12,
    };

    var map=new google.maps.Map(document.getElementById("map"),mapProp);

    var marker, i;
    var infowindow = new google.maps.InfoWindow();
    
    for (i=0; i<locations.length; i++){
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(locations[i][0], locations[i][1]),
        map: map
      });

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function () {
          infowindow.setContent("Yeah!");
          infowindow.open(map, marker);
        }
      })(marker, i));
    }
  }
  initMap();

});