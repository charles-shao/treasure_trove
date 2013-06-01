/**
 * Created with JetBrains RubyMine.
 * User: vintage
 * Date: 1/06/13
 * Time: 1:41 PM
 * To change this template use File | Settings | File Templates.
 */
var geocoder;
var map;

function initialize() {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(-34.397, 150.644);
    var mapOptions = {
        zoom: 8,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}

function codeAddress() {
    var address = document.getElementById('address').value; // REPLACE WITH STRING TO LOOK UP DIV TAG
    geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {

            map.setCenter(results[0].geometry.location);

            var marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location
            });

        } else {
            alert('Geocode was not successful for the following reason: ' + status);
        }
    });
}

google.maps.event.addDomListener(window, 'load', initialize);