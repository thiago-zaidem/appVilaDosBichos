AutoForm.hooks
	updateProfile:
		onSuccess: (formType, result) ->
			perfil = ""

			_.map this.updateDoc.$set, (value,key) ->
				if key is 'profile.perfil'
					perfil = value

			provider = Providers.findOne({nome:this.currentDoc.profile.nomeCompleto})

			#Redireciona a rota caso o tipo do cadastro for usuario ou prestador
			if perfil is "user" or provider != undefined
				sAlert.success 'Perfil atualizado com sucesso.'
			else
				Router.go("/provider")

			#sAlert.success 'Perfil atualizado. Aguarde...'

	updatePicture:
		onSuccess: (operation, result, template) ->
			sAlert.success 'Foto atualizada'
		onError: (operation, error, template) ->
			sAlert.error error

# Autoupdate form
# Autoform's autosave="true" wasn't working
Template.profile.events
	'change form#updatePicture input': (e,t) ->
		Meteor.setTimeout ->
			$('form#updatePicture').submit()
		, 10

Template.profile.rendered = ()->
	$("body").removeAttr('style')
	Meteor.subscribe('profilePictures')

Template.profile.helpers
  listUser: ->
    return Meteor.user()