Template.about.helpers
  listEquipe: ()->
    return Equipe.find({"auditoria.deleted":false},{sort:{auditoria:{createdAt:-1}}}).fetch()
