AutoForm.hooks
	formService:
		onSuccess: (operation, result) ->
			if operation is 'update'
				sAlert.success 'Serviços atualizados com sucesso'
				#Router.go '/dashboard'
		onError: (name, error, template) ->
			console.log(name + " error:", error)

Template.service.helpers
	selectedServiceDoc: ->
		return Providers.findOne({"auditoria.userCreate":Meteor.userId()})