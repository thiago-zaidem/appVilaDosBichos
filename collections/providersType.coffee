@ProvidersType = new Meteor.Collection('providersType')

Schemas.ProvidersType = new SimpleSchema
	tipo:
	  type: String

	slug:
	  type: String

	auditoria:
	  type: Schemas.Auditoria

ProvidersType.attachSchema(Schemas.ProvidersType)