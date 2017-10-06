# These values get propagated through the app
# E.g. The 'name' and 'subtitle' are used in seo.coffee

@Config =

	# Basic Details
	name: 'All Connect'
	title: ->
			TAPi18n.__ 'configTitle'
	subtitle: ->
			TAPi18n.__ 'configSubtitle'
	logo: ->
		'<b>' + @name + '</b>'
	footer: ->
		@name + ' - Copyright ' + new Date().getFullYear()

	# Emails
	emails:
		from: 'no-reply@' + Meteor.absoluteUrl()
		contact: 'hello' + Meteor.absoluteUrl()

	# Username - if true, users are forced to set a username
	username: false
	
	# Localisation
	defaultLanguage: 'en'
	dateFormat: 'D/M/YYYY'

	# Meta / Extenrnal content
	privacyUrl: 'http://meteorfactory.io'
	termsUrl: 'http://meteorfactory.io'

	# For email footers
	legal:
		address: 'Rua 8E, Qd. 29, LT. 05 - Res. Park Garavelo - Aparecida de Goiânia-GO'
		name: 'Grupo AllConnect'
		url: 'http://www.grupoallconnect.com.br'
		phone: '(62) 3588.6443 | 3094.2161'
		email: 'contato@grupoallconnect.com.br'
		logoUrl: 'http://mycompany.com/logo.png'

	about: 'http://www.grupoallconnect.com.br/quem-somos'
	#blog: 'http://learn.meteorfactory.io'

	socialMedia:
		facebook:
			url: 'http://facebook.com/grupoallconnect'
			icon: 'facebook'
		twitter:
			url: 'http://twitter.com/grupoallconnect'
			icon: 'twitter'
	###
	github:
		url: 'http://github.com/yogiben'
		icon: 'github'
	info:
		url: 'http://meteorfactory.io'
		icon: 'link'

	###

	#Routes
	homeRoute: '/'
	publicRoutes: ['home']
	dashboardRoute: '/dashboard'

	#Profiles
	profileDashbord: "Paciente,Profissional"