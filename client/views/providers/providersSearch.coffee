markerJson = []

Template.maps.created = ->
	@mapReady = new ReactiveVar false
	GoogleMaps.load({key: 'AIzaSyCU9x2LIIDvkHtQLQHQ9KGBsqT0RpH2_n0', libraries: 'places' })

	@_stopInterceptValue = false
	data = @.data

	params = this.data.search[0].fields
	searchParams = params
	searchParams = _.extend searchParams, {"auditoria.deleted":false}

	if params.cidade != undefined
		searchParams = _.extend searchParams, "schedule.appointments":{$elemMatch:{city:params.cidade}}

	provider = Providers.find(searchParams).fetch()
	lon = 0
	lat = 0
	i = 0
	markerJson = []

	_.map provider, (value, key) ->
		_.map value.schedule.appointments, (val, key) ->
			locality = JSON.parse(val.serviceLocationSchedules)
			markerJson.push({
				_id: value._id
				index: i
				title: value.nome
				especialidade: value.perfilTipo
				info:
					city: val.city
					startTime: val.startTime
					endTime: val.endTime
					weekDay: val.weekDay
				url: ''
				address: locality.address
				lon: locality.lng
				lat: locality.lat})
			i++

	data = _.extend data, provider:markerJson

initTemplateAndGoogleMapsSearch = ->
	map = new (google.maps.Map)(document.getElementById('map-canvas'),
	  scrollwheel: true
	  disableDefaultUI: true
	  mapTypeId: google.maps.MapTypeId.ROADMAP
	  styles: [
	    {
	      'featureType': 'landscape.natural'
	      'elementType': 'geometry.fill'
	      'stylers': [
	        { 'visibility': 'on' }
	        { 'color': '#e0efef' }
	      ]
	    }
	    {
	      'featureType': 'poi'
	      'elementType': 'all'
	      'stylers': [ { 'visibility': 'off' } ]
	    }
	    {
	      'featureType': 'poi'
	      'elementType': 'geometry.fill'
	      'stylers': [
	        { 'visibility': 'on' }
	        { 'hue': '#1900ff' }
	        { 'color': '#c0e8e8' }
	      ]
	    }
	    {
	      'featureType': 'road'
	      'elementType': 'geometry'
	      'stylers': [
	        { 'lightness': 100 }
	        { 'visibility': 'simplified' }
	      ]
	    }
	    {
	      'featureType': 'road'
	      'elementType': 'labels'
	      'stylers': [ { 'visibility': 'on' } ]
	    }
	    {
	      'featureType': 'transit'
	      'elementType': 'labels'
	      'stylers': [ { 'visibility': 'off' } ]
	    }
	    {
	      'featureType': 'transit.line'
	      'elementType': 'geometry'
	      'stylers': [
	        { 'visibility': 'on' }
	        { 'lightness': 700 }
	      ]
	    }
	    {
	      'featureType': 'water'
	      'elementType': 'all'
	      "stylers": [
	        {
	          "color": "#3d4961"
	        }
	      ]
	    }
	  ])

	currentMarker = 0;

	setMyPosition = ->
	  if ! !navigator.geolocation
	    navigator.geolocation.getCurrentPosition (position) ->
	      geolocate = new (google.maps.LatLng)(position.coords.latitude, position.coords.longitude)

	      marker = new (google.maps.Marker)(
	        position: geolocate
	        animation: google.maps.Animation.DROP
	        map: map
	        title: 'You are here'
	        icon: 'img/maps/you-are-here.png'
	        zIndex: 999999999)

	      map.setCenter geolocate
	      return
	  else
	    alert 'No Geolocation Support.'
	  return

	closeSearcher = ->
	  hideSearcher true
	  return

	nextAds = ->
	  currentMarker++
	  closeSearcher()

	  if currentMarker > totalMarkers
	    currentMarker = 1

	  while markers[currentMarker - 1].visible == false
	    currentMarker++
	    if currentMarker > totalMarkers
	      currentMarker = 1

	  map.panTo markers[currentMarker - 1].getPosition()
	  google.maps.event.trigger markers[currentMarker - 1], 'click'

	  return

	prevAds = ->
	  currentMarker--
	  closeSearcher()

	  if currentMarker < 1
	    currentMarker = totalMarkers

	  while markers[currentMarker - 1].visible == false
	    currentMarker--
	    if currentMarker > totalMarkers
	      currentMarker = 1

	  map.panTo markers[currentMarker - 1].getPosition()
	  google.maps.event.trigger markers[currentMarker - 1], 'click'

	  return

	ControlSet = (leftControlSet, rightControlSet, map) ->
	# SET CSS FOR THE ZOOMIN
	  zoomInButton = document.createElement('div')
	  zoomInElement = document.createAttribute('class')
	  zoomInElement.value = 'zoom-in'
	  zoomInButton.setAttributeNode zoomInElement

	  # SET CSS FOR THE ZOOMOUT
	  zoomOutButton = document.createElement('div')
	  zoomOutElement = document.createAttribute('class')
	  zoomOutElement.value = 'zoom-out'
	  zoomOutButton.setAttributeNode zoomOutElement

	  # SET CSS FOR THE CONTROLL POSITION
	  positionButton = document.createElement('div')
	  controlPositionWrapper = document.createAttribute('class')
	  controlPositionWrapper.value = 'set-position'
	  positionButton.setAttributeNode controlPositionWrapper

	  # SET CSS FOR THE CONTROLL POSITION
	  nextButton = document.createElement('div')
	  controlPositionWrapper = document.createAttribute('class')
	  controlPositionWrapper.value = 'next-ads'
	  nextButton.setAttributeNode controlPositionWrapper

	  # SET CSS FOR THE CONTROLL POSITION
	  prevButton = document.createElement('div')
	  controlPositionWrapper = document.createAttribute('class')
	  controlPositionWrapper.value = 'prev-ads'
	  prevButton.setAttributeNode controlPositionWrapper

	  # APPEND ELEMENTS
	  leftControlSet.appendChild zoomInButton
	  leftControlSet.appendChild zoomOutButton
	  leftControlSet.appendChild positionButton
	  rightControlSet.appendChild prevButton
	  rightControlSet.appendChild nextButton

	  # SETUP THE CLICK EVENT LISTENER - ZOOMIN
	  google.maps.event.addDomListener zoomInButton, 'click', ->
	    if map.getZoom() <= 16 then map.setZoom(map.getZoom() + 1) else null
	    closeSearcher()
	    return

	  # SETUP THE CLICK EVENT LISTENER - ZOOMOUT
	  google.maps.event.addDomListener zoomOutButton, 'click', ->
	    if map.getZoom() >= 4 then map.setZoom(map.getZoom() - 1) else null
	    closeSearcher()
	    return

	  # SETUP THE CLICK EVENT LISTENER - POSITION
	  google.maps.event.addDomListener positionButton, 'click', ->
	    return setMyPosition()
	    closeSearcher()
	    return

	  # SETUP THE CLICK EVENT LISTENER - PREVIOUS ADS
	  google.maps.event.addDomListener prevButton, 'click', ->
	    prevAds()

	  # SETUP THE CLICK EVENT LISTENER - NEXT ADS
	  google.maps.event.addDomListener nextButton, 'click', ->
	    nextAds()
	  return

	# CREATE THE DIV TO HOLD THE CONTROL AND CALL THE CONTROLSET() CONSTRUCTOR
	# PASSING IN THIS DIV.
	leftControlSet = document.createElement('div')
	leftWrapperClass = document.createAttribute('class')
	leftWrapperClass.value = 'control-left-wrapper'
	leftControlSet.setAttributeNode leftWrapperClass

	rightControlSet = document.createElement('div')
	rightWrapperClass = document.createAttribute('class')
	rightWrapperClass.value = 'control-right-wrapper'
	rightControlSet.setAttributeNode rightWrapperClass

	#map.controls[google.maps.ControlPosition.TOP_LEFT].push leftControlSet
	#map.controls[google.maps.ControlPosition.TOP_RIGHT].push rightControlSet
	#ControlSet = new ControlSet(leftControlSet, rightControlSet, map)

	marker = undefined
	i = undefined
	markers = []
	markerCluster = null

	result = $('.find-result')
	#`var markerCluster`

	totalSearch = (numResult) ->
	  result.text(numResult + markerJson[0].especialidade + ' encontrados').addClass 'active'
	  return

	$.each markerJson, (index, locations) ->
		#console.log(index)
		#console.log(locations)
		### ===================================================================== ###

		$typeTarget = $('#property-type a[data-type="' + locations.propertyType + '"] strong')
		$valueProperty = parseInt($typeTarget.text(), 10)
		$typeTarget.text $valueProperty + 1

		#iconStandard = '/img/maps/' + locations.propertyType + '-pin.png'
		iconStandard = '/img/maps/apartamento-pin.png'

		marker = new (google.maps.Marker)(
		  position: new (google.maps.LatLng)(locations.lat, locations.lon)
		  map: map
		  animation: google.maps.Animation.DROP
		  icon: iconStandard
		  propertyType: locations.propertyType)

		### ===================================================================== ###

		google.maps.event.addListener marker, 'mouseover', ->
		  #@setIcon '/img/maps/' + locations.propertyType + '-hover-pin.png'
		  @setIcon '/img/maps/apartamento-hover-pin.png'
		  return

		google.maps.event.addListener marker, 'mouseout', ->
		  #@setIcon '/img/maps/' + locations.propertyType + '-pin.png'
		  @setIcon '/img/maps/apartamento-pin.png'
		  return

		# ADD MARKER TO MAPS
		markers.push marker
		google.maps.event.addListener marker, 'click', do (marker, i) ->
		  ->
		    $('.infoBox').fadeOut 300
		    box = '<div class="ads-maps">' +
		      '<a href="' + locations.url + '" class="img-container" style="background-image:url(' + locations.img + ')">' +
		      '<span class="title">' + locations.title + '</span>' +
		      '</a>' +
		      '<div class="price">$ ' + locations.info.city + '</div>' +
		      '<ul class="details">' +
		      '<li class="bed-room">' + locations.info.startTime + '</li>' +
		      '<li class="bath-room">' + locations.info.endTime + '</li>' +
		      '<li class="size">' + locations.info.weekDay + '</li>' +
		      '</ul>' +
		      '</div>';

		    infoBubble = new InfoBubble(
		      content: box
		      position: new (google.maps.LatLng)(locations.lat, locations.lon)
		      shadowStyle: 0
		      backgroundColor: 'rgb(61, 73, 97)'
		      borderRadius: 10
		      borderWidth: 0
		      disableAutoPan: false
		      hideCloseButton: false
		      padding: 5
		      minWidth: 330
		      minHeight: 340
		      pixelOffset: new (google.maps.Size)(-160, -382)
		      zIndex: null
		      boxStyle: width: '330px'
		      closeBoxMargin: '0'
		      closeSrc: '/img/maps/close.png'
		      infoBoxClearance: new (google.maps.Size)(1, 1))

		    infoBubble.open map, marker

		    map.panTo marker.getPosition()

		    closeSearcher()
		    return
		return
	totalMarkers = markers.length

	totalSearch totalMarkers

	autoCenter = ->
	# CREATE A NEW VIEWPOINT BOUND
	  bounds = new (google.maps.LatLngBounds)

	  # GO THROUGH EACH...
	  x = 0

	  while x < totalMarkers
	    bounds.extend markers[x].position
	    x++

	  # FIT THESE BOUNDS TO THE MAP
	  map.fitBounds bounds
	  return

	autoCenter()

	showVisibleMarkers = ->
		bounds = map.getBounds()
		count = 0
		i = 0
		while i < markers.length
			marker = markers[i]
			infoPanel = $('.info-' + i)
			# array indexes start at zero, but not our class names :)
			if bounds.contains(marker.getPosition()) == true
				infoPanel.show()
				count++
			else
				infoPanel.hide()
			i++
		totalSearch count
		return

	markerCluster = new MarkerClusterer(map, markers,
	  gridSize: 40
	  minimumClusterSize: 2
	  imagePath: '/img/maps/m'
	  calculator: (markers_list, numStyles) ->
	    {
	      text: markers_list.length
	      index: numStyles
	    }
	)

	# FILTER MARKER
	filter = []

	$('#property-type .item-type').on 'click touchstart', ->
	  $(this).toggleClass 'item-selected'

	  closeSearcher()

	  properyClick = @dataset.type

	  newBounds = new (google.maps.LatLngBounds)

	  propertyFound = 0

	  if $.inArray(properyClick, filter) == -1 then filter.push(properyClick) else filter.splice(filter.indexOf(properyClick), 1)

	  markerCluster.removeMarkers markers, false
	  x = 0
	  while x < totalMarkers
	    if $.inArray(markers[x].propertyType, filter) >= 0
	      markers[x].setVisible true
	      markerCluster.addMarker markers[x], false
	      propertyFound++

	      # SET NEW POSITION MAPS
	      newBounds.extend markers[x].position
	    else
	      markers[x].setVisible false
	      markerCluster.removeMarker markers[x]

	      # SET NEW POSITION MAPS
	      newBounds.extend markers[x].position

	    totalSearch propertyFound
	    x++

	  if filter.length == 0
	    totalSearch totalMarkers
	    x = 0
	    while x < totalMarkers
	      markers[x].setVisible true
	      markerCluster.addMarker markers[x], false
	      # SET NEW POSITION MAPS
	      newBounds.extend markers[x].position
	      x++

	  # SET NEW POSITION MAPS
	  map.fitBounds newBounds

	  autoCenter()
	  false

	google.maps.event.addListenerOnce map, 'idle', ->
		$('.loading-container').delay(3000).fadeOut()
		return

	google.maps.event.addListener map, 'idle', ->
		showVisibleMarkers()
		return

	@mapReady.set true

Template.maps.rendered = () ->
	$('.header-v6').addClass('header-fixed-shrink')
	@autorun =>
		GoogleMaps.loaded() and initTemplateAndGoogleMapsSearch.apply this

	#image = Attachments.find({_id:value.destaque}).fetch()

	###markerJson.push({_id:value._id, title:value.dono, description:"descriçao",
		info:{price:value.preco, bathRoom:value.banheiros, bedRoom:value.dormitorios, perimeter:value.metragem},
		img:"/cfs/files/Attachments/"+image[0]._id+"/"+image[0].copies.attachments.name, propertyType:value.tipo,
		url:"",lon:lon,lat:lat})###

###
{
"id"    :  1,
"title" : "Property 1",
"description" : "Morbi non convallis lectus. Vivamus ipsum arcu, fringilla auctor justo sit amet, laoreet auctor sem. Cras mattis, lectus non tincidunt placerat, ante nisi finibus libero: 960-DB4436",
"info"  : {"price": "280,000", "bathRoom": 2, "bedRoom": 3, "perimeter": 130, "room": 4},
"img"   : "images/sample/property/p1.jpg", }
"propertyType" : "apartement",
"url"   : "property-detail.html",
"lon"   : -74.0000439,
"lat"   : 40.7205914
}
###
Template.maps.helpers
	listProviders: ->
		obj = Template.instance().data.provider
		return obj