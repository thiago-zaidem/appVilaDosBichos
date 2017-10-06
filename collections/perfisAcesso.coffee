Schemas.PerfisAcesso = new SimpleSchema
  nome:
    type: String

  menu:
    type: [String]
    label : "Selecione um menu"
    autoform :
      afFieldInput:
        type: "select-checkbox"
        options: ->
          doc = {}
          doc = AdminConfig.collections
          return _.map(doc, (obj, key) ->
            return {label: obj.label, value: key}
          )

  acoes:
    type: [String]
    label: "Ações"
    autoform :
      afFieldInput:
        type: "select-checkbox"
        options: ->
          doc = {}
          #doc = {Inserir:"Inserir", Editar:"Editar", Editar_um:"Editar um registro", Apagar:"Apagar", Visualizar:"Visualizar"}
          doc = {Inserir:"Inserir", Editar:"Editar", Apagar:"Apagar", Visualizar:"Visualizar"}
          return _.map(doc, (obj, key) ->
            return {label: obj, value: key}
          )

  auditoria:
    type: Schemas.Auditoria

PerfisAcesso.attachSchema(Schemas.PerfisAcesso)
