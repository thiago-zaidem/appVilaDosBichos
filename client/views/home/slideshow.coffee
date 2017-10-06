Template.slideshow.helpers
  listAll: ->
    return Slideshow.find({"auditoria.deleted": false}, {sort:{createdAt: -1}}).fetch()
