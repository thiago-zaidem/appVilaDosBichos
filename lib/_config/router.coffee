@subs = new SubsManager()

Router.configure
  layoutTemplate: "masterLayout"
  loadingTemplate: "loading"
  notFoundTemplate: "notFound"
  routeControllerNameConverter: "camelCase"

  onBeforeAction: ->
  	# Redirect to set username if required
    if Config.username and Meteor.userId() and not Meteor.user().username
      @redirect '/setUserName'
    @next()


Router.waitOn ->
  subs.subscribe 'user'
  subs.subscribe 'RolesProfile'

onAfterAction = ->
  if Meteor.isClient
    window.scrollTo(0,0)

    # Remove modal
    $bd =  $('.modal-backdrop')
    $bd.removeClass('in')
    setTimeout ->
      $bd.remove()
    , 300

Router.onAfterAction onAfterAction

#To allow non-logged in users to access more routes, add it in the config file
Router.plugin 'ensureSignedIn', except: [
	'home'
	'about'
	'servicos'
	'clientes'
	'contato'
	'providers.search'
	'providers.detail'
	'atSignIn'
	'atSignUp'
	'atForgotPassword'
	'atSignOut'
]
