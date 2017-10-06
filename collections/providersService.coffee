@ProvidersService = new Meteor.Collection('providersService')

Schemas.ProvidersService = new SimpleSchema(
	nome:
		type: String

	descricao:
		type: String

	padrao:
		type: Boolean

	auditoria:
		type: Schemas.Auditoria
)

ProvidersService.attachSchema(Schemas.ProvidersService)