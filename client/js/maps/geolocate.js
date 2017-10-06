// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.

GMaps = function (){
			function geolocation(mapInstance) {
				var map = mapInstance;
				if (navigator.geolocation) {
					navigator.geolocation.getCurrentPosition(function(position) {
						var geoPosition = {
							lat: position.coords.latitude,
							lng: position.coords.longitude
						};
						google.maps.event.trigger(map, 'resize');
						map.setCenter(geoPosition);
					});
				}
			}
			return{
				userLocation: function (mapInstance) {
					geolocation(mapInstance);
				}
			}
}();
