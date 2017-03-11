$(document).ready(function(){
  var geocoder;
  var map;
  function initialize() {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(40.415023, -3.673920);
    var mapOptions = {
      zoom: 12,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById("map"), mapOptions);
  }
  initialize();
  var actual_marker;
  $('.validate-address-button').on('click', function codeAddress() {
    var address = $('#space_address_1').val() + $('#space_address_2').val() 
    + ", " + $('#space_city').val() + $('#space_country').val();
    if (actual_marker != null){
      DeleteMarkers();
    }
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        map.setCenter(results[0].geometry.location);
        var marker = new google.maps.Marker({
          map: map,
          position: results[0].geometry.location
        });
        map.setZoom(15);
        actual_marker=marker;
        $('#space_longitude').val(results[0].geometry.location.lng());
        $('#space_latitude').val(results[0].geometry.location.lat());
      } else {
        console.log("Geocode was not successful for the following reason: " + status);
      }
    });
  });
  function DeleteMarkers() {
    //Loop through all the markers and remove
    actual_marker.setMap(null);
    actual_marker=null;
  };

  $('#space_full_availability').on('change', function(){
    if ($('#space_full_availability').val() == "true") {
      $('.space-availability-selectors').hide();
    } else {
      $('.space-availability-selectors').show();
    }
    
  });
});