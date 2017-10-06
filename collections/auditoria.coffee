@Auditoria = new Meteor.Collection('auditoria');

Schemas.Auditoria = new SimpleSchema
  userCreate:
    type: String
    optional: true
    denyUpdate: true
    regEx: SimpleSchema.RegEx.Id
    autoValue: (user)->
      if this.isInsert
        Meteor.userId()

  createdAt:
    type: Date
    denyUpdate: true
    autoValue: ->
      if this.isInsert
        new Date()

  userUpdate:
    type: String
    optional: true
    regEx: SimpleSchema.RegEx.Id
    autoValue: (user)->
      if this.isInsert or this.isUpdate
        Meteor.userId()

  updatedAt:
    type:Date
    optional:true
    autoValue: ->
      if this.isUpdate
        new Date()

  deleted:
    type: Boolean
    defaultValue: false

Auditoria.attachSchema(Schemas.Auditoria);