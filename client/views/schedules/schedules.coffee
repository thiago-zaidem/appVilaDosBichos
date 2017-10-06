AutoForm.hooks
  formSchedule:
    onSuccess: (operation, result, template) ->
      if operation is 'update'
	      sAlert.success 'Agenda atualizada com sucesso'
	      Router.go '/dashboard'
	###formServiceLocation:
    onSuccess: (operation, result, template) ->
	    doc = this.insertDoc
	    $('input.autocomplete-autoform').autocomplete().val(doc.nome);
	    $("#close-modal").trigger('click');
	    sAlert.success 'Local de atendimento gravado com sucesso'###

Template.schedule.helpers
	selectedScheduleDoc: ->
		return Providers.findOne({"auditoria.userCreate":Meteor.userId()})

###Template.schedule.rendered = () ->
  doc = ServiceLocation.find({"auditoria.deleted":false},{fields:{nome:1}}).fetch()
  location = {}
  obj = {}
  _.map doc, (objKey)->
    obj[objKey.nome] = null
    location = _.extend location, obj

  $('#autocomplete-input').autocomplete({
      data:location,
      limit: 20, # The max amount of results that can be shown at once. Default: Infinity.
      minLength: 1 # The minimum length of the input for the autocomplete to start. Default: 1.
  });###

###
Template.modalNew.rendered = () ->
	$("#new-modal").perfectScrollbar()

Template.modalNew.events
	'shown.bs.modal #new-modal': (e)->
		GMaps.userLocation(window.map)###
