Meteor.methods
  insertDoc: (doc,collection)->
    check arguments, [Match.Any]
    this.unblock()
    result = adminCollectionObject(collection).insert doc
    return result