@Pets = new Meteor.Collection('pets');

Schemas.Pets = new SimpleSchema(
	userId:
		type: String
		autoform:
			type: "hidden"
			label: false
		autoValue: ->
			if this.isInsert or this.isUpdate
				return Meteor.userId()

	picture:
		type: String
		label: 'Foto do pet'
		optional: true
		autoform:
			afFieldInput:
				type: 'fileUpload'
				collection: 'Attachments'
				buttonEnabled: false
				dropEnabled: true
				dropClasses: "dropify"

	nome:
		type: String

	especie:
		type: String
		label: "Espécie"

	raca:
		type: String
		label: "Raça"

	nascimento:
		type: Date
		optional: true
		label: "Data de nascimento"
		optional: true
		autoform:
			afFieldInput:
				type: "pickadate"
				pickadateOptions:
					selectYears: 100
					selectMonths: true
					format: 'd mmmm, yyyy'

	genero:
		type: String
		label: "Gênero"
		autoform:
			type: "select-radio-inline",
			options: ->
				return [
					{label: "Masculino", value: "masculino", defaultValue: true}
					{label: "Feminino", value: "feminino"}
				]

	peso:
		type: String
		autoform:
			type: "select"
			firstOption:"(Escolha uma opção)"
			options: ->
				return [
					{label: "Menos de 1kg", value: "Menos de 1kg", defaultValue: true}
					{label: "De 2 a 4,5 kg", value: "De 2 a 4,5 kg"}
					{label: "Acima de 4,5 a 10kg", value: "Acima de 4,5 a 10kg"}
					{label: "Acima de 10 a 20kg", value: "Acima de 10 a 20kg"}
					{label: "Acima de 20 a 40kg", value: "Acima de 20 a 40kg"}
					{label: "Acima de 40kg", value: "Acima de 40kg"}
				]

	cores:
		type: String

	coresOlhos:
		type: String
		optional: true
		label: "Cores dos olhos"

	amigavel:
		type: [String]
		optional: true
		label: 'Amigável com'
		autoform:
			type: "select-checkbox-inline"
			labelClass: "select-label-active"
			options: ->
				return [
					{label: "Crianças", value: "crianças", defaultValue: true}
					{label: "Animais", value: "animais"}
					{label: "Animal Treinado", value: "animal treinado"}
				]

	comandos:
		type: [String]
		optional: true
		autoform:
			type: "select-checkbox"
			labelClass: "select-label-active"
			options: ->
				return [
					{label: "Anda em pé", value: "Anda em pé", defaultValue: true}
					{label: "Corre", value: "Corre"}
					{label: "Dá a Pata", value: "Dá a Pata"}
					{label: "Deita", value: "Deita"}
					{label: "Desce", value: "Desce"}
					{label: "Fica", value: "Fica"}
					{label: "Fica em pé", value: "Fica em pé"}
					{label: "Finge de Morto", value: "Finge de Morto"}
					{label: "Gira", value: "Gira"}
					{label: "Late", value: "Late"}
					{label: "Levanta", value: "Levanta"}
					{label: "Pula", value: "Pula"}
					{label: "Rola", value: "Rola"}
					{label: "Senta", value: "Senta"}
					{label: "Target", value: "Target"}
					{label: "Trazer Objetos", value: "Trazer Objetos"}
				]

	auditoria:
		type: Schemas.Auditoria
)

Pets.attachSchema(Schemas.Pets)