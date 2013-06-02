var geocoder;
var map;
var infowindow = new google.maps.InfoWindow();

function displayMap() {
                    document.getElementById('map_canvas').style.display="block";
                    initialize();
                }

// TODO: fix up
function full_load(locations) {

    var mapOptions = {
        zoom: 13,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    geocoder = new google.maps.Geocoder();

    var bounds = new google.maps.LatLngBounds();

    console.log(locations);

    for (var ad = 0; ad < locations.length; ad++) {
        geocoder.geocode({'address': locations[ad]}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
                setTimeout(function(){}, 500);
            }

            if (status == google.maps.GeocoderStatus.OK) {

                for (var i = 0; i < results.length; i++) {
                    marker = createMarker(results[i]);
                    bounds.extend(marker.getPosition());
                }

                map.fitBounds(bounds);
            } else {
                alert('Geocode was not successful for the following reason: ' + status);
            }
        });
    }

}

function initialize(address) {
    geocoder = new google.maps.Geocoder();
    geocoder.geocode( {'address': address}, function(results, status) {
        if (results != "") {
            if (status == google.maps.GeocoderStatus.OK) {
                var mapOptions = {
                    zoom: 13,
                    center: results[0].geometry.location,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

                var bounds = new google.maps.LatLngBounds();
                for (var i = 0; i < results.length; i++) {
                    marker = createMarker(results[i]);
                    bounds.extend(marker.getPosition());
                }

                map.fitBounds(bounds);
            } else {
                alert('Geocode was not successful for the following reason: ' + status);
            }
        } else{
            $("#map-canvas").text("No geocode found.")
        }
    });
}

function callback(results, status) {
    if (status == google.maps.places.PlacesServiceStatus.OK) {
        for (var i = 0; i < results.length; i++) {
            createMarker(results[i]);
        }
    }
}

function createMarker(place) {
    var placeLoc = place.geometry.location;
    var marker = new google.maps.Marker({
        map: map,
        position: place.geometry.location
    });

    google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(place.name);
        infowindow.open(map, this);
    });

    return marker;
}


