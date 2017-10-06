Meteor.methods
  validaInscricao: (items)->
    if Roles.userIsInRole this.userId, ['Organização']
      this.unblock()
      itens = {}
    selected = template.findAll( "input[type=checkbox]:checked");

    itens = _.map selected, (item)->
      return item.defaultValue

      _.map items, (item)->
        if item != ""
          result = Inscricoes.insert {user:item}
          Meteor.user.update({_id:item},$set:{validacao:true})
          return result

  sendEmail: (to, name, message)->
    console.log("sending...");

    this.unblock();

    PrettyEmail.send 'basic',
      to: 'contato@grupoallconnect.com.br'
      subject: 'Mensagem enviada pelo site'
      heading: 'Seu(ua) cliente ' + name + ' lhe enviou um email através do site.'
      message: message