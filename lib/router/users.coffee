Router.map ->
	@route "profile",
	 path: "/profile"
	 title: "Perfil"
	 waitOn: -> [
	   subs.subscribe 'providers'
	 ]

	@route "provider",
	 path: "/provider"
	 title: "Profissional"
	 waitOn: -> [
	   subs.subscribe 'providers'
	   subs.subscribe 'providersType'
	 ]

	@route "schedule",
	 path: "/schedule"
	 title: "Atendimento"
	 waitOn: -> [
	    subs.subscribe 'providers'
	    subs.subscribe 'planosSaude'
	 ]

	@route "service",
	 path: "/service"
	 title: "Serviços"
	 waitOn: -> [
	   subs.subscribe 'providers'
	   subs.subscribe 'providersService'
	 ]

	@route "pets",
	path: "/pets"
	title: "Meus pets"
	waitOn: -> [
	  subs.subscribe 'pets'
	  subs.subscribe 'attachments'
	]

	@route "account",
	 path: "/account"
	 title: "Conta"

	@route "setUserName",
	 path: "/setUserName"
	 onBeforeAction: ->
	   if not Config.username or (Meteor.userId() and Meteor.user().username)
	     @redirect '/dashboard'
	   @next()

	@route 'signOut',
	 path: '/sign-out'
	 onBeforeAction: ->
	   Meteor.logout ->
	   @redirect '/'
	   @next()