@QuemSomos = new Meteor.Collection("quemSomos");

Schemas.QuemSomos = new SimpleSchema
  quemSomos:
    type: String
    label:"Quem Somos"
    max: 1000
    autoform:
      rows:7

  missao:
    type: String
    label:"Missão"
    max: 1000
    autoform:
      rows:7

  visao:
    type: String
    label:"Visão"
    max: 1000
    autoform:
      rows:7

  picture:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'fileUpload'
        collection: 'Attachments'

  auditoria:
    type: Schemas.Auditoria

QuemSomos.attachSchema(Schemas.QuemSomos);

