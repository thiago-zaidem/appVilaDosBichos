Template.listProviders.helpers
  tableSettings: ()->
    mail = Meteor.user().emails[0].address
    return {
      collection: Providers
      items: Providers.find({'auditoria.userCreate':Meteor.userId()}).fetch()
      rowsPerPage: 10
      showFilter: true
      checkbox: false
      multiSelect: false
      fields: [
        {key:'dono', label: 'Nome Completo'},
        {key:'endereco.logradouro', label:'Logradouro'},
        {key:'endereco.bairro', label:'Bairro'},
        {key:'tipo', label:'Tipo'},
        {key:'status', label:'Status'}
        {key:'auditoria.createdAt', label:'Data cadastro'}
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