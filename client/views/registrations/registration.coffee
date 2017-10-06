AutoForm.hooks
  insertInscricao:
    onSuccess: (operation, result, template) ->
      sAlert.success 'Inscrições enviadas'
    onError: (operation, error, template) ->
      sAlert.error error

Template.registration.helpers
  tableSettings: ()->
    mail = Meteor.user().emails[0].address
    return {
      collection: Meteor.users.find({'emails.0.address':{$ne:mail},'profile.validacao':true}).fetch()
      rowsPerPage: 10
      showFilter: true
      checkbox: true
      multiSelect: true
      fields: [
                {key:'profile.nomeCompleto', label: 'Nome Completo'},
                {key:'profile.cpf', label:'CPF'},
                {key:'profile.faculdade', label:'Faculdade'},
                {key:'emails.0.address', label:'Email'},
                {key:'createdAt', label:'Data inscrição'}
              ]
    }

Template.registration.events
  'submit form': (e, template)->
    e.preventDefault()
    itens = {}
    selected = template.findAll( "input[type=checkbox]:checked");

    itens = _.map selected, (item)->
               return item.defaultValue

    Meteor.call 'validaInscricao', itens

    #console.log(itens);

Template.registrationView.helpers
  tableSettings: ()->
    mail = Meteor.user().emails[0].address
    return {
    collection: Meteor.users.find({'emails.0.address':{$ne:mail},'profile.validacao':true}).fetch()
    rowsPerPage: 10
    showFilter: true
    checkbox: false
    multiSelect: true
    fields: [
        {key:'profile.nomeCompleto', label: 'Nome Completo'},
        {key:'profile.cpf', label:'CPF'},
        {key:'profile.faculdade', label:'Faculdade'},
        {key:'emails.0.address', label:'Email'},
        {key:'createdAt', label:'Data inscrição'}
      ]
    }