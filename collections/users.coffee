Schemas.UserProfile = new SimpleSchema(
	picture:
		type: String
		label: 'Foto do perfil'
		optional: true
		autoform:
			afFieldInput:
				type: 'fileUpload'
				collection: 'ProfilePictures'
				buttonEnabled: false
				dropEnabled: true
				dropClasses: "dropify"

	code:
		type: String
		label: "Código do usuário"
		autoform:
			placeholder: "Código gerado automaticamente"
			disabled: true
		autoValue: ->
			if this.isInsert
		      return randomCode()

	nomeCompleto:
		type: String
		autoValue: ->
			if this.isInsert
				return ""

	perfil:
		type: String
		label: "Tipo de usuário"
		autoform:
			type: "select-radio-inline"
			options: ->
				return [
					{label: "Usuário", value: "user", defaultValue: true}
					{label: "Prestador de serviço", value: "provider"}
					{label: "ONG", value: "ong"}
				]
		autoValue: ->
			if this.isInsert
				return "user"

	cnpj:
		type: String
		label: "CNPJ (Obrigatório para Prestador de serviço ou ONG)"
		optional: true
		autoform:
			placeholder: "sem pontos e hífen"
		autoValue: ->
			if this.isInsert
				return ""
		custom: ->
			if this.siblingField('perfil').value == "provider" or this.siblingField('perfil').value == "ong"
				if this.value is undefined or this.value == ""
					return "required"

	cpf:
	   type: String
	   label: "CPF (Obrigatório para usuário)"
	   optional: true
	   autoform:
	      placeholder: "sem pontos e hífen"
	   autoValue: ->
		   if this.isInsert
			   return ""
	   custom: ->
		   if this.siblingField('perfil').value != "provider" and this.siblingField('perfil').value != "ong"
			   if Meteor.isClient and this.isUpdate
				   return "cpfError" if testCpfValid(this.value) is false

	nascimento:
		type: Date
		label: "Data de nascimento (Obrigatório para usuário)"
		optional: true
		autoform:
			afFieldInput:
				type: "pickadate"
				pickadateOptions:
					selectYears: 100
					selectMonths: true
					format: 'd mmmm, yyyy'
		custom: ->
			if this.siblingField('perfil').value != "provider" and this.siblingField('perfil').value != "ong"
				if ((this.value is undefined or this.value == "") and (this.isUpdate))
					return "required"

	sexo:
		type: String
		label: "Sexo (Obrigatório para usuário)"
		optional: true
		autoform:
			type: "select-radio-inline"
			options: ->
				return [
					{label: "Masculino", value: "masculino", defaultValue: true}
					{label: "Feminino", value: "feminino"}
				]
		autoValue: ->
			if this.isInsert
				return "masculino"
		custom: ->
			if this.siblingField('perfil').value != "provider" and this.siblingField('perfil').value != "ong"
				if this.value is undefined or this.value == ""
					return "required"

	termo:
		type: Boolean
		optional: true
		label: "Aceito os termos de uso"
		custom: ->
			if Meteor.isClient and testIsChecked(this.value) is false
				return "validacaoTermo"
)

Schemas.User = new SimpleSchema(
	profile:
		type: Schemas.UserProfile
		optional: true
		label: "Dados Cadastrais"

	username:
		type: String
		regEx: /^[a-z0-9A-Z_]{3,15}$/
		optional: true

	emails:
		type: [Object]
		optional: true

	"emails.$.address":
		type: String
		regEx: SimpleSchema.RegEx.Email

	"emails.$.verified":
		type: Boolean

	createdAt:
		type: Date

	services:
		type: Object
		optional: true
		blackbox: true

	roles:
		type: [String]
		blackbox: true
		optional: true

	status:
		type: Object
		optional: true

	'status.lastLogin.date':
		type: Date
		optional: true

	'status.lastLogin.ipAddr':
		type: String
		optional: true

	'status.userAgent':
		type: String
		optional: true

	'status.idle':
		type: Boolean
		optional: true

	'status.lastActivity':
		type: Date
		optional: true

	'status.online':
		type: Boolean
		index: true
		optional: true
)

Meteor.users.attachSchema Schemas.User

testIsChecked = (checked) ->
  if checked
    return true
  else
    return false

testCpfValid = (strCpf) ->
  Resto = 0;
  Soma = 0;

  return false if strCpf is "00000000000";

  i = 1
  while i>=9
    Soma = Soma + parseInt(strCpf.substring(i-1, i)) * (11 - i);
    i++

  Resto = (Soma * 10) % 11
  Resto = 0 if (Resto is 10) or (Resto is 11)

  return false unless Resto is parseInt(strCpf.substring(9, 10))
  Soma = 0

  i = 1
  while i<=10
    Soma = Soma + parseInt(strCpf.substring(i-1, i)) * (12 - i);
    i++

  Resto = (Soma * 10) % 11;
  Resto = 0 if Resto is 10 or Resto is 11

  return false unless parseInt(strCpf.substring(10, 11) )

  true

randomCode = () ->
  text = ''
  code = ''
  #possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
  possible = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  i = 0
  while i < 25
    text += possible.charAt(Math.floor(Math.random() * possible.length))
    i++
  i = 0
  while i < 6
    code += text.charAt(Math.floor(Math.random() * text.length))
    i++
  code

@StarterSchemas = Schemas
