@Config =
  name: 'Portal Saúde'
  urlImg: ->
    '/img/logo3-light.png'
  title: ->
    TAPi18n.__ 'configTitle'
  subtitle: ->
    TAPi18n.__ 'configSubtitle'
  logo: ->
    '<b>' + @name + '</b>'
  footer: ->
    @name + ' - Copyright ' + new Date().getFullYear()

  # Emails
  emails:
    from: 'no-reply@' + Meteor.absoluteUrl()
    contact: 'hello' + Meteor.absoluteUrl()

  # Username - if true, users are forced to set a username
  username: false

  # Localisation
  defaultLanguage: 'pt-BR'
  dateFormat: 'D/M/YYYY'

  # Meta / Extenrnal content
  privacyUrl: 'http://meteorfactory.io'
  termsUrl: 'http://meteorfactory.io'

  # For email footers
  legal:
    address: 'Rua Florianópolis, Nº 110 - Bairro Alto da Glória - Goiânia-GO'
    name: 'Portal Saude'
    url: 'http://www.portalsaude.med.br'

  about: 'http://www.portalsaude.med.br/quem-somos'
  #blog: 'http://learn.meteorfactory.io'

  socialMedia:
    facebook:
      url: 'http://facebook.com/portalsaude'
      icon: 'facebook'
    twitter:
      url: 'http://twitter.com/portalsaude'
      icon: 'twitter'

  ###
    github:
      url: 'http://github.com/yogiben'
      icon: 'github'
    info:
      url: 'http://meteorfactory.io'
      icon: 'link'
  ###

  #Routes
  homeRoute: '/'
  publicRoutes: ['home']
  dashboardRoute: '/dashboard'
  dashboardLogo: ->
    '/img/logo_portal_branco.png'

  #Profiles
  profileDashboard: ["admin","profissional","equipe"]
  defaultProfile: "profissional"

Avatar.options =
	customImageProperty: 'profile.picture'

Meteor.startup ->
	if Meteor.isClient
    for property of Template
    # check if the property is actually a blaze template
      if Blaze.isTemplate(Template[property])
        template = Template[property]
        # assign the template an onRendered callback who simply prints the view name
        template.onRendered ->
          $('select').material_select();
          slideHeight = $(window).height()
          this.$('.section-height').css('height',slideHeight)
          this.$(window).resize( ()-> $('.section-height').css('height', slideHeight))
          return

    TAPi18n.setLanguage('pt')
    #i18n.setLanguage('pt-br')
    T9n.setLanguage("pt")
    moment.locale('pt-br')

    globalMessages = _.clone(SimpleSchema._globalMessages)
    Meteor.autorun ->
      lang = TAPi18n.getLanguage()
      localMessages = TAPi18n.__('simpleschema.messages', returnObjectTrees: true)
      localMessages.regEx = _.map(localMessages.regEx, (item) ->
        if item.exp
          item.exp = eval(item.exp)
        item
      )
      messages = _.extend(_.clone(globalMessages), localMessages)
      SimpleSchema.messages messages
      return