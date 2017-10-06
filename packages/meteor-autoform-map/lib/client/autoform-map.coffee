KEY_ENTER = 13

defaults =
	mapType: 'roadmap'
	autocomplete: false
	defaultLat: 1
	defaultLng: 1
	geolocation: false
	searchBox: false
	autolocate: false
	zoom: 1

lat = undefined
lng = undefined
address = undefined
item = {}

AutoForm.addInputType 'map',
	template: 'afMap'
	valueOut: ->
		node = $(@context)

		lat = node.find('.js-lat').val()
		lng = node.find('.js-lng').val()
		address = node.find('.js-place-address').val()

		if lat?.length > 0 and lng?.length > 0
			lat: lat
			lng: lng

		if address?.length
			address

	contextAdjust: (ctx) ->
		ctx.loading = new ReactiveVar(false)
		ctx
	valueConverters:
		string: (value) ->
				atts = @.context.$blaze_range.view._templateInstance.data.atts
				if atts.autocomplete
					if item.length == 0
						item = {address:value,lng:lng,lat:lat}
					else if item.address != value
									item = {address:value,lng:lng,lat:lat}
					JSON.stringify(item)
				else
					if @attr('reverse')
						"#{value.lng},#{value.lat}"
					else
						"#{value.lat},#{value.lng}"
		numberArray: (value) ->
			if value.address
				_.extend value, {lng:lng,lat:lat}
				[value.lng, value.lat, value.address]
			else
				[value.lng, value.lat]

Template.afMap.created = ->
	@mapReady = new ReactiveVar false
	GoogleMaps.load({key: 'AIzaSyCU9x2LIIDvkHtQLQHQ9KGBsqT0RpH2_n0', libraries: 'places' })

	@_stopInterceptValue = false
	@_interceptValue = (ctx) ->
		t = Template.instance()
		if t.mapReady.get() and ctx.value and not t._stopInterceptValue
			location = if typeof ctx.value == 'string' then ctx.value.split ',' else if ctx.value.hasOwnProperty 'lat' then [ctx.value.lat, ctx.value.lng] else [ctx.value[1], ctx.value[0]]
			location = new google.maps.LatLng parseFloat(location[0]), parseFloat(location[1])
			t.setMarker t.map, location, t.options.zoom
			t.map.setCenter location
			t._stopInterceptValue = true

initTemplateAndGoogleMaps = ->
	@options = _.extend {}, defaults, @data.atts
	
	if !@data.atts.autocomplete
		@data.marker = undefined
		@setMarker = (map, location, zoom=0) =>
			@$('.js-lat').val(location.lat())
			@$('.js-lng').val(location.lng())

			if @data.marker then @data.marker.setMap null
			@data.marker = new google.maps.Marker
				position: location
				map: map

			if zoom > 0
				@map.setZoom zoom

		mapOptions =
			zoom: 0
			mapTypeId: google.maps.MapTypeId[@options.mapType]
			streetViewControl: false

		if @data.atts.googleMap
			_.extend mapOptions, @data.atts.googleMap

		@map = new google.maps.Map @find('.js-map'), mapOptions

		@map.setCenter new google.maps.LatLng @options.defaultLat, @options.defaultLng
		@map.setZoom @options.zoom

		if @data.atts.searchBox
			input = @find('.js-search')

			@map.controls[google.maps.ControlPosition.TOP_LEFT].push input
			searchBox = new google.maps.places.SearchBox input

			google.maps.event.addListener searchBox, 'places_changed', =>
				location = searchBox.getPlaces()[0].geometry.location
				@setMarker @map, location
				@map.setCenter location

			$(input).removeClass('af-map-search-box-hidden')

		if @data.atts.autolocate and navigator.geolocation and not @data.value
			navigator.geolocation.getCurrentPosition (position) =>
				location = new google.maps.LatLng position.coords.latitude, position.coords.longitude
				@setMarker @map, location, @options.zoom
				@map.setCenter location

		if typeof @data.atts.rendered == 'function'
			@data.atts.rendered @map

		google.maps.event.addListener @map, 'click', (e) =>
			@setMarker @map, e.latLng

		@$('.js-map').closest('form').on 'reset', =>
			@data.marker and @data.marker.setMap null
			@map.setCenter new google.maps.LatLng @options.defaultLat, @options.defaultLng
			@map.setZoom @options?.zoom or 0

		window.map = @map

		@mapReady.set true
	else
		div = @
		prefixAddressObjName = div.data.name.substr(0, div.data.name.lastIndexOf('.'))

		if prefixAddressObjName != undefined
			inputLocality = $("input[name='"+prefixAddressObjName+".locality']")
			inputCity = $("input[name='"+prefixAddressObjName+".city']")
			inputUf = $("input[name='"+prefixAddressObjName+".uf']")
		else
			inputLocality = $("input[name='locality']")
			inputCity = $("input[name='city']")
			inputUf = $("input[name='uf']")

		input = @find('.js-autocomplete')
		options = {
			types: [],
			componentRestrictions: {country: 'br'}
		}

		autocomplete = new google.maps.places.Autocomplete(input, options);
		autocomplete.addListener 'place_changed', ->
			place = autocomplete.getPlace();
			placeStreetSublocality = "#{place.address_components[1].long_name} - #{place.address_components[2].long_name}"
			placeStateCountry = "#{place.address_components[3].long_name} - #{place.address_components[5].short_name}, #{place.address_components[6].long_name}"
			placeAddress = "#{place.name} - #{placeStreetSublocality}, #{placeStateCountry}"
			div.$('.js-lat').val(place.geometry.location.lat())
			div.$('.js-lng').val(place.geometry.location.lng())
			div.$('.js-place-address').val(placeAddress)
			inputLocality.val(place.address_components[2].long_name)
			inputCity.val(place.address_components[3].long_name)
			inputUf.val(place.address_components[5].short_name)

Template.afMap.rendered = ->
	params = @.data.atts;
	value = if @data.value then JSON.parse(@data.value) else @data.value
	@autorun =>
		GoogleMaps.loaded() and initTemplateAndGoogleMaps.apply this

	if params.materialIcon
		$('.js-autocomplete').addClass('icon');

	if value.address
		@.$('.js-autocomplete').val(value.address)
		@.$('.js-lat').val(value.lat)
		@.$('.js-lng').val(value.lng)
		@.$('.js-place-address').val(value.address)

Template.afMap.helpers
	schemaKey: ->
		Template.instance()._interceptValue @
		@atts['data-schema-key']
	width: ->
		if typeof @atts.width == 'string'
			@atts.width
		else if typeof @atts.width == 'number'
			@atts.width + 'px'
		else
			'100%'
	height: ->
		if typeof @atts.height == 'string'
			@atts.height
		else if typeof @atts.height == 'number'
			@atts.height + 'px'
		else
			'200px'
	icon: ->
		@atts.materialIcon
	loading: ->
		@loading.get()

Template.afMap.events
	'click .js-locate': (e, t) ->
		e.preventDefault()

		unless navigator.geolocation then return false

		@loading.set true
		t = Template.instance()
		navigator.geolocation.getCurrentPosition (position) =>
			location = new google.maps.LatLng position.coords.latitude, position.coords.longitude
			t.setMarker t.map, location, @options?.zoom
			t.map.setCenter location
			@loading.set false

	'keydown .js-search': (e) ->
		if e.keyCode == KEY_ENTER then e.preventDefault()
