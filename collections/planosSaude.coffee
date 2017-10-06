@PlanosSaude = new Meteor.Collection('planosSaude');

Schemas.PlanosSaude = new SimpleSchema
  nome:
    type: String

  auditoria:
    type: Schemas.Auditoria

PlanosSaude.attachSchema(Schemas.PlanosSaude)
