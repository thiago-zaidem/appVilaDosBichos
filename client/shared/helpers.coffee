Template.registerHelper 'Config', ->
	Config

Template.registerHelper 'NCSchemas', ->
	NCSchemas

Template.registerHelper 'socialMedia', ->
	_.map Config.socialMedia, (obj)->
    obj

Template.registerHelper 'Utils', ->
  Utils

Template.registerHelper 'currentRoute', ->
  if Router and Router.current and Router.current()
    Router.current()

Template.registerHelper 'isRouteReady', ->
  Router and Router.current and Router.current() and Router.current()._waitlist._notReadyCount == 0

Template.registerHelper 'formatDate', (date)->
  return moment(date).format('DD-MM-YYYY')

Template.registerHelper 'listPics', (_ids) ->
  return Attachments.find({_id: { $in: _ids }}).fetch()

Template.registerHelper 'getPic', (_id, collection) ->
  if window[collection]
    if window[collection].findOne _id
      window[collection].findOne _id

Template.registerHelper 'equals', (valA, valB) ->
  valA == valB

Template.registerHelper 'isProvider', ->
	obj = Meteor.users.findOne({_id:Meteor.userId()})
	if obj.profile.perfil is 'provider' then return true else return false