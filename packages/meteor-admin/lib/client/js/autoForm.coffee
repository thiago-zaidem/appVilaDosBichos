AutoForm.setDefaultTemplate 'materialize'

# Add hooks used by many forms
AutoForm.addHooks [
		'admin_insert',
		'admin_update',
		'adminNewUser',
		'adminUpdateUser',
		'adminSendResetPasswordEmail',
		'adminChangePassword',
		'panel_insert',
		'panel_update'],
	beginSubmit: ->
		$('.btn-primary').addClass('disabled')
	endSubmit: ->
		$('.btn-primary').removeClass('disabled')
	onError: (formType, error)->
		AdminDashboard.alertFailure error.message

AutoForm.hooks
	admin_insert:
		onSubmit: (insertDoc, updateDoc, currentDoc)->
      hook = @
      Meteor.call 'adminInsertDoc', insertDoc, Session.get('admin_collection_name'), (e,r)->
        if e
          hook.done(e)
        else
          adminCallback 'onInsert', [Session.get 'admin_collection_name', insertDoc, updateDoc, currentDoc], (collection) ->
            hook.done null, collection
      return false
    onSuccess: (formType, collection)->
      AdminDashboard.alertSuccess 'Successfully created'
      Router.go "/admin/#{collection}"

	admin_update:
		onSubmit: (insertDoc, updateDoc, currentDoc)->
      hook = @
      Meteor.call 'adminUpdateDoc', updateDoc, Session.get('admin_collection_name'), Session.get('admin_id'), (e,r)->
        if e
          hook.done(e)
        else
          adminCallback 'onUpdate', [Session.get 'admin_collection_name', insertDoc, updateDoc, currentDoc], (collection) ->
            hook.done null, collection
      return false
    onSuccess: (formType, collection)->
      AdminDashboard.alertSuccess 'Successfully updated'
      if checkUserAction 'Editar_um', Meteor.userId()
        Router.go '/admin'
      else
        Router.go "/admin/#{collection}"

	adminNewUser:
		onSuccess: (formType, result)->
			AdminDashboard.alertSuccess 'Created user'
			Router.go '/admin/Users'

	adminUpdateUser:
		onSubmit: (insertDoc, updateDoc, currentDoc)->
			Meteor.call 'adminUpdateUser', updateDoc, Session.get('admin_id'), @done
			return false
		onSuccess: (formType, result)->
      AdminDashboard.alertSuccess 'Updated user'
      if checkUserAction 'Editar_um', Meteor.userId()
        Router.go '/admin'
      else
        Router.go '/admin/Users'

	adminSendResetPasswordEmail:
		onSuccess: (formType, result)->
			AdminDashboard.alertSuccess 'Email sent'

	adminChangePassword:
		onSuccess: (operation, result, template)->
			AdminDashboard.alertSuccess 'Password reset'

	panel_insert:
		onSubmit: (insertDoc, updateDoc, currentDoc)->
			hook = @
			Meteor.call 'adminInsertDoc', insertDoc, Session.get('panel_collection_name'), (e,r)->
				if e
					hook.done(e)
				else
					adminCallback 'onInsert', [Session.get 'panel_collection_name', insertDoc, updateDoc, currentDoc], (collection) ->
						hook.done null, collection
			return false
		onSuccess: (formType, collection)->
			AdminDashboard.alertSuccess 'Criado com sucesso'
			Router.go "/panel/#{collection}"

	panel_update:
		onSubmit: (insertDoc, updateDoc, currentDoc)->
			hook = @
			Meteor.call 'adminUpdateDoc', updateDoc, Session.get('panel_collection_name'), Session.get('panel_id'), (e,r)->
				if e
					hook.done(e)
				else
					adminCallback 'onUpdate', [Session.get 'panel_collection_name', insertDoc, updateDoc, currentDoc], (collection) ->
						hook.done null, collection
			return false
		onSuccess: (formType, collection)->
			AdminDashboard.alertSuccess 'Atualizado com sucesso'
			if checkUserAction 'Editar_um', Meteor.userId()
				Router.go '/panel'
			else
				Router.go "/panel/#{collection}"
