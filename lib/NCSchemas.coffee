@NCSchemas = {}

NCSchemas.updatePassword = new SimpleSchema
  old:
    type: String
    label: "Senha atual"
    max: 50

  new:
    type: String
    min: 6
    max: 20
    label: "Nova senha"

  confirm:
    type: String
    min: 6
    max: 20
    label: "Confirmar nova senha"