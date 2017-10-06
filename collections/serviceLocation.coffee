@ServiceLocation = new Meteor.Collection("serviceLocation");

Schemas.ServiceLocation = new SimpleSchema
  nome:
    type: String
    label: "Nome*"
    
  address:
    type: Schemas.Adresses
    label: "Endereço"

  auditoria:
    type: Schemas.Auditoria

ServiceLocation.attachSchema(Schemas.ServiceLocation)
  