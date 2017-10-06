@Appointments = new Meteor.Collection('appointments');

Schemas.Appointments = new SimpleSchema(
	providerId:
		type: String

	clientId:
		type: String

	local:
		type: String

	date:
		type: Date

	time:
		type: String

	auditoria:
		type: Schemas.Auditoria
)

Appointments.attachSchema(Schemas.Appointments);