AutoForm.hooks
	formPets:
		onSuccess: (operation, result, template) ->
			if operation is 'update'
				sAlert.success 'Cadastro de pets atualizado com sucesso'
			else if operation is 'insert'
				Router.go("/dashboard")
		onError: (operation, error, template) ->
			sAlert.error error


Template.pets.helpers
	selectedPets: ()->
		obj = Pets.findOne({"auditoria.userCreate":Meteor.userId()})
		if obj != undefined then formType = "update" else formType = "insert"

		return {
			doc: obj
			form: formType
		}