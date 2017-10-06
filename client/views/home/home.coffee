Template.home.rendered = () ->
  $('.header-v6').removeClass('header-fixed-shrink')

  #App.initRangerSlider()
  #App.initEasyDropdown()
  App.initSpinner()
  App.initParallaxBg()
  #App.initScrollBar()
  MSfullWidth.initMSfullDefault()
  OwlCarousel.initOwlCarousel()
  
  w = new WOW().init()

  # TODO: End after home destroyed

  # make sure div stays full width/height on resize
  # global vars
  winWidth = $(window).width()
  winHeight = $(window).height()

  # set initial div height / width
  $("#intro").css
    width: winWidth
    height: winHeight

  $(window).resize ->
    $("#intro").css
      width: $(window).width()
      height: $(window).height()

  #Skroll doesn't work so well on mobile imo
  unless Utils.isMobile
    options =
      forceHeight: false
      smoothScrolling: false

    skrollr.init(options).refresh()

Template.home.destroyed = () ->
	#For Skrollr
	$('body').attr('style','')
  
Template.searchBox.events
	'click button': ()->
	  providersHistorySearch = {}
	  fieldsSearch = {}

	  user = Meteor.users.find({userId: {$exists: false}},{fields:{userId:1,'status.lastLogin.ipAddr':1}}).fetch()
	  providersHistorySearch = _.extend providersHistorySearch, {ipAddr: user[0].status.lastLogin.ipAddr, userId:user[0]._id}

	  perfilTipo = $("select[name=perfil] option:selected").val()
	  cidade = $("input[name=cidade]").val()
	  especialidade = $("select[name=especialidade] option:selected").val()

	  if perfilTipo != ""
	    fieldsSearch = _.extend fieldsSearch, {perfilTipo:perfilTipo}

	  if cidade != ""
	    fieldsSearch = _.extend fieldsSearch, {cidade:cidade}

	  if especialidade != "" and especialidade != "todas"
	    fieldsSearch = _.extend fieldsSearch, {especialidade:especialidade}

	  providersHistorySearch = _.extend providersHistorySearch, {fields:fieldsSearch}
	  strJson = JSON.stringify(fieldsSearch)
	  encodedString = btoa(strJson)

	  Meteor.call 'insertDoc', providersHistorySearch, 'ProvidersHistorySearch', (error,result)->
	    if error
	      Router.go "providers.search", {_id:'noId'}, {query:{encodedString}}
	    else
	      Router.go "providers.search", {_id:result}

Template.searchBox.created = () ->
	this.areas = new ReactiveVar(null)

Template.searchBox.rendered = () ->
	t = Template.instance()
	@autorun =>
		if t.areas.get()
			$('#select-especialidade').material_select('destroy')
		Tracker.afterFlush ->
			$('#select-especialidade').material_select()

Template.searchBox.helpers
	listPerfil: ->
	  ProvidersType.find({"auditoria.deleted":false}).fetch()

	areas: ->
		Template.instance().areas.get()

	getEspecialidades: (areas) ->
		if areas is null then areas = "Médico"
		Providers.find({perfilTipo:areas, "auditoria.deleted":false},{fields:{especialidade:1}}).fetch()

Template.searchBox.events
	'change #select-perfil': (event, instance)->
		instance.areas.set(event.currentTarget.value)

	'focus #autocomplete-input': (e)->
		perfilTipo = $("#select-perfil option:selected").val()
		cities = Providers.find(
			{perfilTipo:perfilTipo, "auditoria.deleted":false},
			{fields:{"schedule.appointments":1}}
		).fetch()
		cityState = {}

		_.map cities, (key) ->
			_.map key.schedule.appointments, (key) ->
				citie = key.city
				cityState[citie] = null

		$('input.autocomplete').autocomplete({
			data: cityState
			limit: 20
			minLength: 1
		});