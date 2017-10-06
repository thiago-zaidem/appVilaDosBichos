AutoForm.hooks
	formProvider:
		onSuccess: (operation, result, template) ->
			if operation is 'update'
				sAlert.success 'Dados profissionais atualizado com sucesso'
			else if operation is 'insert'
						Router.go("/schedule")
		onError: (operation, error, template) ->
			sAlert.error error


Template.provider.helpers
	selectedProvider: ()->
		obj = Providers.findOne({"auditoria.userCreate":Meteor.userId()})
		if obj != undefined then formType = "update" else formType = "insert"

		return {
		  doc: obj
		  form: formType
		}