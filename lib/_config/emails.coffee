if Meteor.isServer
  process.env.MAIL_URL = 'smtp://contato@grupoallconnect.com.br:Contato123@smtp.zoho.com:587'
  #process.env.MAIL_URL = 'smtp://administrador@grupoallconnect.com.br:*ZOh@193482*@smtp.zoho.com:587'

  options =
    siteName: Config.name

  if Config.socialMedia
    _.each Config.socialMedia, (v,k) ->
      options[k] = v.url

  if Config.legal
    options.companyAddress = Config.legal.address
    options.companyName = Config.legal.name
    options.companyUrl = Config.legal.url
    options.companyTelephone = Config.legal.phone
    options.companyEmail = Config.legal.email
    options.from = Config.legal.email
    options.showFooter = true
    #options.logoUrl = Config.legal.logoUrl

  PrettyEmail.options = options