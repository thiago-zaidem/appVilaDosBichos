Schemas.contatoSchema = new SimpleSchema
  nome:
    type: String

  email:
    type: String
      regEx: SimpleSchema.RegEx.Email

  telefone:
    type: String
    #regEx: /^(\(11\) [9][0-9]{4}-[0-9]{4})|(\(1[2-9]\) [1-9][0-9]{3}-[0-9]{4})|(\([2-9][1-9]\) [1-9][0-9]{3}-[0-9]{4})$/

  cidadeEstado:
    type: String
    label: "Cidade/Estado"

  mensagem:
    type: String
    autoform:
      rows: 5