@ProvidersHistorySearch = new Meteor.Collection('providersHistorySearch')

Schemas.ProvidersHistorySearch = new SimpleSchema
  ipAddr:
    type: String

  userId:
    type: String
    optional: true

  fields:
    label: "Campos da busca"
    type: Object
    optional: true

  'fields.perfilTipo':
    type: String
    optional: true

  'fields.especialidade':
    type: String
    optional: true

  'fields.cidade':
    type: String
    optional: true

  'fields.planoSaude':
    type: Number
    optional: true

  'fields.dormitorios':
    type: Number
    optional: true

  'fields.metragem':
    type: Number
    optional: true

  'fields.minPrice':
    type: String
    optional: true

  'fields.maxPrice':
    type: String
    optional: true

  auditoria:
    type: Schemas.Auditoria

ProvidersHistorySearch.attachSchema(Schemas.ProvidersHistorySearch)