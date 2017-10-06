@Adresses = new Meteor.Collection('adresses');

Schemas.Adresses = new SimpleSchema
  street:
    type: String
    label: "Endereço*"

  number:
    type: String
    label: "Número*"
    autoform:
      row: false
      groupClass: 'col s3'

  neighborhood:
    type: String
    label: "Bairro*"
    autoform:
      row: false
      groupClass: 'col s3'

  complement:
    type: String
    label: "Complemento"
    optional: true

  county:
    type: String
    label: "Município*"
    autoform:
      row: false
      groupClass: 'col s3'

  state:
    type: String
    label: "Estado-UF*"
    autoform:
      row: false
      groupClass: 'col s3'

  zip:
    type: String
    label: "CEP*"
    max: 9
    regEx: /^[0-9]{8}$/
    autoform:
      row: false
      groupClass: 'col s3'

  location:
    type: String
    autoform:
      label: false
      type: 'map'
      mapType: 'ROADMAP'
      zoom: 17
      geolocation: true
      searchBox: false
      autolocate: true
      height: 400

  landline1:
    type: String
    label: "Fixo 1*"
    autoform:
      mask: '(00)0000-0000'
      row: false
      groupClass: 'col s3'


  landline2:
    type: String
    label: "Fixo 2"
    optional: true
    autoform:
      mask: '(00)0000-0000'
      row: false
      groupClass: 'col s3'

  cellphone1:
    type: String
    label: "Celular 1"
    optional: true
    autoform:
      mask: '(00)00000-0000'
      row: false
      groupClass: 'col s3'

  cellphone2:
    type: String
    label: "Celular 2"
    optional: true
    autoform:
      mask: '(00)00000-0000'
      row: false
      groupClass: 'col s3'

Adresses.attachSchema(Schemas.Adresses);

Schemas.Adresses.messages
  regEx:[
    exp: SimpleSchema.RegEx.ZipCode
    msg: "[label] deve ser válido"
  ]