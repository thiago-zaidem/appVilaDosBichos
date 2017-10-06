# You'll want to replace these functions. They publish the whole
# collection which is problematic after your app grows

Meteor.publish 'posts', ->
	Posts.find()

Meteor.publish 'attachments', ->
	Attachments.find()

Meteor.publish 'Users', ->
  Users.find()

Meteor.publish 'quemSomos', ->
  QuemSomos.find()

Meteor.publish 'equipe', ->
  Equipe.find()

Meteor.publish 'servicos', ->
  Slideshow.find()

Meteor.publish 'pets', ->
	Pets.find()

Meteor.publish 'providers', ->
  Providers.find()

Meteor.publish 'clientes', (options)->
  Clientes.find({},options)

Meteor.publish 'profilePictures', ->
  ProfilePictures.find()

Meteor.publish 'registrationUser', ->
  Meteor.users.find({_id:{$ne:'Meteor.userId()'},'profile.termo':true},
                    {fields:{
                               'profile.nomeCompleto':1,
                               'profile.faculdade':1,
                               'profile.cpf':1,
                               createdAt:1,
                               'emails.address':1,
                               'profile.validacao':1
                            }
                    })

Meteor.publish 'providersHistorySearch', ->
  ProvidersHistorySearch.find({})

Meteor.publish "providersType", ->
  ProvidersType.find()

Meteor.publish "providersService", ->
   ProvidersService.find()

Meteor.publish "planosSaude", ->
  PlanosSaude.find()

Meteor.publish "serviceLocation", ->
  ServiceLocation.find()

Meteor.publish 'UserConnections', ->
  Meteor.users.find({},{fields:{
    userId:1,
    'status.lastLogin.date':1,
    'status.lastLogin.ipAddr':1,
    'status.userAgent':1,
    'status.idle':1,
    'status.lastActivity':1,
    'status.online':1}
  })