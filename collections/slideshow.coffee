@Slideshow = new Meteor.Collection('slideshow');

Schemas.Slideshow = new SimpleSchema
  titulo: 
    type: String
    max: 50
  
  texto:
    type: String
    autoform:
      rows: 4

  clientes:
    type: String

  imgCapa:
    type: String
    label: 'Imagem principal'
    autoform:
      afFieldInput:
        type:'fileUpload'
        collection: 'Attachments'

  pictures:
    type: [String]
    label: 'Galeria de imagens' # optional

  "pictures.$":
    type: String
    autoform:
      afFieldInput:
        type: 'fileUpload'
        collection: 'Attachments'

  auditoria:
    type: Schemas.Auditoria

Slideshow.attachSchema(Schemas.Slideshow);