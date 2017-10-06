AutoForm.hooks
  updateUserDetail:
    onSuccess: (operation, result, template) ->
      sAlert.success 'Detalhes do perfil atualizado'
    onError: (operation, error, template) ->
      sAlert.error error

Template.profile.helpers
  listUser: ->
    return Meteor.user()
