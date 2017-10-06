ListController = RouteController.extend
	template: 'clientes'
	increment: 5
	limit: ->
	  parseInt(this.params.viewLimit) || this.increment
	findOptions: ->
	  {sort: {createdAt: -1}, limit: this.limit()}
	waitOn: ->
	  [
	    subs.subscribe 'attachments'
	    subs.subscribe 'clientes', this.findOptions()
	  ]
	listClient: ->
	  Clientes.find({"auditoria.deleted": false},this.findOptions())
	data: ->
	  hasMore = this.listClient().count() == this.limit()
	  nextPath = this.route.path({viewLimit: this.limit() + this.increment})
	  clients: this.listClient()
	  nextPath: if hasMore then nextPath else null
	  footer: 'true'

Router.map ->
	@route "home",
	  path: "/"
	  layoutTemplate: "homeLayout"
	  waitOn: ->
	    [
	      subs.subscribe 'providers'
	      subs.subscribe 'UserConnections'
	      subs.subscribe 'providersType'
	    ]
	  data: ->
	    footer: 'false'

	@route "providers",
	  path: "/providers/:_id"
	  name: "providers.search"
	  layoutTemplate: "homeLayout"
	  waitOn: ->
	    [
	      subs.subscribe 'providers'
	      subs.subscribe 'providersHistorySearch'
	      subs.subscribe 'attachments'
	    ]
	  data: ->
	    id = this.params._id

	    if id == 'noId'
	      searchParams = atob(this.params.query.encodedString)

	    search: ProvidersHistorySearch.find({_id:id}).fetch()
	    footer: 'false'

	@route "details",
		path: "/details/:_id"
		name: "providers.detail"
		layoutTemplate: "homeLayout"
		waitOn: ->
			[
				subs.subscribe 'providers'
				subs.subscribe 'providersHistorySearch'
				subs.subscribe 'attachments'
			]
		data: ->
			id = this.params._id

			provider: Providers.findOne({_id:id})
			footer: 'true'

	@route "dashboard",
		path: "/dashboard"
		title: "Painel"
		waitOn: ->
		[
			subs.subscribe 'providers'
			subs.subscribe 'pets'
			subs.subscribe 'comments'
			subs.subscribe 'attachments'
		]
		data: ->
		posts: Posts.find({},{sort: {createdAt: -1}}).fetch()

	@route "about",
	  path: "/about"
	  layoutTemplate: "homeLayout"
	  waitOn: ->
	    [
	      subs.subscribe 'quemSomos'
	      subs.subscribe 'equipe'
	      subs.subscribe 'attachments'
	    ]
	  data: ->
	    conteudo: QuemSomos.find({"auditoria.deleted":false},{_id:0}).fetch()
	    footer: 'true'

	@route "servicos",
	  path: "/services"
	  layoutTemplate: "homeLayout"
	  waitOn: ->
	    [
	      subs.subscribe 'servicos'
	      subs.subscribe 'attachments'
	    ]
	  data: ->
	    servicos: Slideshow.find({"auditoria.deleted": false}, {sort:{createdAt: -1}}).fetch()
	    footer: 'true'

	###
	@route "clientes",
	  path: "/clientes"
	  layoutTemplate: "homeLayout"
	  waitOn: ->
	    [
	      subs.subscribe 'clientes'
	    ]
	  data: ->
	    clientes: Clientes.find({"auditoria.deleted": false}, {sort:{createdAt: -1}}).fetch()
	    footer: 'true'
	###

	@route "contato",
	  path: "/contato"
	  layoutTemplate: "homeLayout"
	  data: ->
	    footer: 'true'

	@route "listProviders",
	  path: "/listProviders"
	  waitOn: ->
	    [
	      subs.subscribe 'providers'
	    ]

	@route "imoveisCreate",
	  template: "cadProviders"
	  path: "/cadProviders"

	###
	@route "clientes",
	  path: "/:viewLimit?"
	  layoutTemplate: "homeLayout"
	  controller: ListController

	###
