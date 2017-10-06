@Noticias = new Meteor.Collection('noticias');

Schemas.Noticias = new SimpleSchema
  titulo:
    type: String

  introducao:
    type: String

  texto:
    type: String
    autoform:
      rows: 4

  picture:
    type: String
    autoform:
      afFieldInput:
        type: 'fileUpload'
        collection: 'Attachments'

  auditoria:
    type: Schemas.Auditoria

Noticias.attachSchema(Schemas.Noticias)

