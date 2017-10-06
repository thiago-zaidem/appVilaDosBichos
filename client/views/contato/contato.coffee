Template.contato.events
 'submit': (e)->
    e.preventDefault()
    #waitingDialog.show('Enviando email.');
    to  = $("input[name='email']").val()
    name = $("input[name='nome']").val()
    message = $("textarea[name='mensagem']").val()

    sAlert.info('Enviando email.', {timeout: 'none'})

    Meteor.call 'sendEmail', to, name, message, (error, result)->
      if (error)
        console.log(error)
        sAlert.closeAll()
        sAlert.error("Email não enviado; " + error.error + ": " + error.reason, {timeout: 'none'})
      else
        sAlert.closeAll()
        sAlert.success('Email enviado com sucesso. Em breve entraremos em contato. Obrigado!', {timeout: 'none'})
        $("#contact").closest('form').find("input[type=text], textarea").val("");
