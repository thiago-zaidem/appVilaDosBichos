@Profissionais = new Meteor.Collection('profissionais');

Schemas.Profissionais = new SimpleSchema
  nome:
    type: String
    autoValue: (user)->
      if this.isInsert or this.isUpdate
        Meteor.user().profile.nomeCompleto

  tipo:
    type: [String]
    autoform :
      afFieldInput:
        type: "universe-select"
        multiple: true
        options: ->
          doc = TipoProfissional.find({"auditoria.deleted":false},{fields:{tipo:1}}).fetch()
          return _.map doc, (obj)->
            return {label: obj.tipo, value: obj.tipo}
    
  crm:
    type: Number
    label: "Incrição CRM"
    optional: true
    autoform:
      placeholder: "somente para médicos"

  curriculum:
    type: String
    autoform:
      rows: 4

  auditoria:
    type: Schemas.Auditoria

Profissionais.attachSchema(Schemas.Profissionais)
