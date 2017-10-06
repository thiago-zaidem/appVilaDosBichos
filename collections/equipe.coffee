@Equipe = new Meteor.Collection('equipe')

Schemas.Equipe = new SimpleSchema
  nome:
    type: String

  picture:
    type: String
    autoform:
      afFieldInput:
        type: 'fileUpload'
        collection: 'Attachments'
        dropEnabled: true
        dropLabel: "Drop your file here"

  cargo:
    type: String

  emails:
    type: [Object]
    optional: true

  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email

  "emails.$.verified":
    type: Boolean

  redeSocial:
    type: String
    optional: true

  auditoria:
    type: Schemas.Auditoria

Equipe.attachSchema(Schemas.Equipe)
