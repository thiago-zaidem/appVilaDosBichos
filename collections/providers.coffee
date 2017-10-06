@Providers = new Meteor.Collection('providers')

Schemas.Services = new SimpleSchema(
	service:
		type: [Object]

	'service.$.type':
		type: String
		label: "Serviço"
		autoform:
			placeholder: "ex. Banho"

	'service.$.price':
		type: Number
		label: "Preço"
		decimal: true
		autoform:
			placeholder: "R$"
			mask: '000.00'

	'service.$.desc':
		type: String
		label: "Descrição"
)

Schemas.Schedules = new SimpleSchema(
	appointments:
		type: [Object]
		label: "Local / Dia e hora de atendimento:"

	"appointments.$.serviceLocationSchedules":
		type: String
		label: "Local de atendimento"
		autoform :
			type: 'map'
			placeholder: "Buscar"
			materialIcon: 'search'
			autocomplete: true
			geolocation: true
			autolocate: true
			height: 400

	"appointments.$.locality":
		type: String
		autoform:
			type: "hidden"
			label: false

	"appointments.$.city":
		type: String
		autoform:
			type: "hidden"
			label: false

	"appointments.$.uf":
		type: String
		autoform:
			type: "hidden"
			label: false

	"appointments.$.weekDay":
		type: [String]
		label: "Dia da semana"
		autoform:
			type: "select-checkbox-inline",
			options: ->
				return [
					{label: "Segunda", value: "segunda"}
					{label: "Terça", value: "terça"}
					{label: "Quarta", value: "quarta"}
					{label: "Quinta", value: "quinta"}
					{label: "Sexta", value: "sexta"}
					{label: "Sábado", value: "sábado"}
					{label: "Domingo", value: "domingo"}
				]

	"appointments.$.startTime":
		type: String
		label: "Horário das"
		autoform:
			type: "time"
			labelClass: 'active'
			afFormGroup:
				row: false
				groupClass: 'col s3'
		custom: ->
			if not Utils.stringToTimeCompare(this.value,this.siblingField('endTime').value)
				return "startTimeBiggerEndTime"

	"appointments.$.endTime":
		type: String
		label: "Horário até"
		autoform:
			type: "time"
			labelClass: 'active'
			afFormGroup:
				row: false
				groupClass: 'col s3'

	"appointments.$.planoSaude":
		type: [String]
		label: 'Plano de saúde'
		autoform:
			type: "select-checkbox-inline"
			labelClass: "select-label-active"
			options: ->
				doc = PlanosSaude.find({"auditoria.deleted":false},{fields:{nome:1}}).fetch()
				return _.map doc, (obj)->
					return {label: obj.nome, value: obj.nome}
)

Schemas.Providers = new SimpleSchema(
	userId:
		type: String
		autoform:
			type: "hidden"
			label: false
		autoValue: ->
			if this.isInsert or this.isUpdate
				return Meteor.userId()

	nome:
		type: String
		optional: true
		defaultValue: ->
			Meteor.user().profile.nomeCompleto.toString()
		autoform:
			readonly: true

	perfilTipo:
		type: [String]
		label: 'Área de atuação'
		autoform :
			type: "select-checkbox-inline"
			labelClass: "select-label-active"
			options: ->
				doc = ProvidersType.find({"auditoria.deleted":false}).fetch()
				return _.map doc, (obj)->
					return {label: obj.tipo, value: obj.slug}

	numeroConselho:
		type: Number
		label: "Nº no conselho (Somente para clínicas)"
		autoform:
			placeholder: "somente números"

	contato:
		type: String
		label: "Telefone de contato"
		autoform:
			mask: '(00)00000-0000'

	quemSomos:
		type: String
		label: "Fale um pouco sobre a empresa ou sobre você (máximo 5000 caracteres)"
		max: 5000
		autoform:
			rows: 10

	instagram:
		type: String

	servico:
		type: Schemas.Services
		label: "Serviços"
		optional: true

	schedule:
		type: Schemas.Schedules
		label: "Dados do atendimento"
		optional: true

	status:
		type:String
		allowedValues: ["Ativo", "Inativo"]
		optional: true
		autoValue: ()->
			if this.isInsert
				"Ativo"

	auditoria:
		type: Schemas.Auditoria
)
Providers.attachSchema(Schemas.Providers)