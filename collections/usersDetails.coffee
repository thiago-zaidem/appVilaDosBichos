@UsersDetails = new Meteor.Collection('usersDetails');

Schemas.UsersDetails = new SimpleSchema
  userCod:
    type: String
    label: "Identificação do usuário"
    autoValue: (user)->
      if this.isInsert or this.isUpdate
        Meteor.userId()

  nome:
    type: String
    autoValue: (user)->
      if this.isInsert or this.isUpdate
        Meteor.user().profile.nomeCompleto

  planoSaude:
    type: [String]
    autoform :
      afFieldInput:
        type: "universe-select"
        multiple: true
        options: ->
          doc = PlanosSaude.find({"auditoria.deleted":false},{fields:{nome:1}}).fetch()
          return _.map doc, (obj)->
            return {label: obj.nome, value: obj.nome}

  auditoria:
    type: Schemas.Auditoria

UsersDetails.attachSchema(Schemas.UsersDetails)
