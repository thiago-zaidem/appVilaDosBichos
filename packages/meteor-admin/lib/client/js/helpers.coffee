Template.registerHelper('AdminTables', AdminTables);

adminCollections = ->
	collections = {}
	widget = false

	if typeof AdminConfig != 'undefined' and typeof AdminConfig.collections == 'object'
		collections = AdminConfig.collections

	collections.Users =
		collectionObject: Meteor.users
		icon: 'user'
		label: 'Usuários'
		sidebar: true

	if Roles.userIsInRole Meteor.userId(), ['admin']
		widget = true

	_.map collections, (obj, key) ->
		obj = _.extend obj, {name: key}
		obj = _.defaults obj, {label: key, icon: 'plus', color: 'blue', sidebar: false, widget: widget, panel: false}
		obj = _.extend obj,
			viewPath: Router.path "adminDashboard#{key}View"
			newPath: Router.path "adminDashboard#{key}New"
			#editPath: Router.path "adminDashboard" + obj.name + "Edit", _id: Meteor.userId()

UI.registerHelper 'AdminConfig', ->
	AdminConfig if typeof AdminConfig != 'undefined'

UI.registerHelper 'admin_skin', ->
	AdminConfig?.skin or 'blue'

UI.registerHelper 'admin_collections', adminCollections

UI.registerHelper 'admin_collection_name', ->
	Session.get 'admin_collection_name'

UI.registerHelper 'admin_current_id', ->
	Session.get 'admin_id'

UI.registerHelper 'admin_current_doc', ->
	Session.get 'admin_doc'

UI.registerHelper 'admin_is_users_collection', ->
	Session.get('admin_collection_name') == 'Users'

UI.registerHelper 'admin_sidebar_items', ->
	sidebarItens = {}
	objCollection = []
	objMenus = []
	userRole = Roles.getRolesForUser Meteor.userId()
	userMenus = PerfisAcesso.find({nome:userRole.toString()},{menu:1}).fetch()

	if typeof AdminConfig != 'undefined' and typeof AdminDashboard.sidebarItems == 'object'
		sidebarItens = AdminDashboard.sidebarItems

	_.each(_.pluck(userMenus, 'menu'), (fn) -> objMenus = fn)

	_.map sidebarItens, (obj, key) ->
		showMenu = false
		_.map obj.options.urls, (newObj, key) ->
			objCollection = [newObj.collection]
			intersec = (_.intersection(objCollection, objMenus))

			if Roles.userIsInRole Meteor.userId(), ['admin']
				newObj = _.extend newObj, {showItem: true}
			else
				if _.isEmpty(intersec)
					newObj = _.extend newObj, {showItem: false}
				else
					newObj = _.extend newObj, {showItem: true}

			if newObj.showItem
				showMenu = true

		obj = _.extend obj, {showMenu: showMenu}
		return obj

UI.registerHelper 'admin_collection_items', ->
	items = []
	_.each AdminDashboard.collectionItems, (fn) =>
		item = fn @name, '/admin/' + @name
		if item?.title and item?.url
			items.push item
	items

UI.registerHelper 'admin_omit_fields', ->
	if typeof AdminConfig.autoForm != 'undefined' and typeof AdminConfig.autoForm.omitFields == 'object'
		global = AdminConfig.autoForm.omitFields
	if not Session.equals('admin_collection_name','Users') and typeof AdminConfig != 'undefined' and typeof AdminConfig.collections[Session.get 'admin_collection_name'].omitFields == 'object'
		collection = AdminConfig.collections[Session.get 'admin_collection_name'].omitFields
	if typeof global == 'object' and typeof collection == 'object'
		_.union global, collection
	else if typeof global == 'object'
		global
	else if typeof collection == 'object'
		collection

UI.registerHelper 'AdminSchemas', ->
	AdminDashboard.schemas

UI.registerHelper 'adminGetSkin', ->
	if typeof AdminConfig.dashboard != 'undefined' and typeof AdminConfig.dashboard.skin == 'string'
		AdminConfig.dashboard.skin
	else
		'blue'

UI.registerHelper 'adminIsUserInRole', (_id,role)->
	Roles.userIsInRole _id, role

UI.registerHelper 'adminGetUsers', ->
	Meteor.users

UI.registerHelper 'adminGetUserSchema', ->
	if _.has(AdminConfig, 'userSchema')
		schema = AdminConfig.userSchema
	else if typeof Meteor.users._c2 == 'object'
		schema = Meteor.users.simpleSchema()

	return schema

UI.registerHelper 'adminCollectionLabel', (collection)->
	AdminDashboard.collectionLabel(collection) if collection?

UI.registerHelper 'adminCollectionCount', (collection)->
	if collection == 'Users'
		Meteor.users.find().count()
	else
		AdminCollectionsCount.findOne({collection: collection})?.count

UI.registerHelper 'adminTemplate', (collection, mode)->
	if collection?.toLowerCase() != 'users' && typeof AdminConfig?.collections?[collection]?.templates != 'undefined'
		AdminConfig.collections[collection].templates[mode]

UI.registerHelper 'adminGetCollection', (collection)->
	_.find adminCollections(), (item) -> item.name == collection

UI.registerHelper 'adminWidgets', ->
	if typeof AdminConfig.dashboard != 'undefined' and typeof AdminConfig.dashboard.widgets != 'undefined'
		AdminConfig.dashboard.widgets

UI.registerHelper 'adminUserEmail', (user) ->
	if user && user.emails && user.emails[0] && user.emails[0].address
		user.emails[0].address
	else if user && user.services && user.services.facebook && user.services.facebook.email
		user.services.facebook.email
	else if user && user.services && user.services.google && user.services.google.email
		user.services.google.email

# ----- PANEL HELPERS -----
Template.registerHelper('PanelTables', PanelTables);

panelCollections = ->
	collections = {}
	widget = false

	if typeof AdminConfig != 'undefined' and typeof AdminConfig.collections == 'object'
		collections = AdminConfig.collections

	if Roles.userIsInRole Meteor.userId(), ['admin']
		widget = true

	_.map collections, (obj, key) ->
		obj = _.extend obj, {name: key}
		obj = _.defaults obj, {label: key, icon: 'plus', color: 'blue', sidebar: false, widget: widget}
		obj = _.extend obj,
			viewPath: Router.path "panelDashboard#{key}View"
			newPath: Router.path "panelDashboard#{key}New"

UI.registerHelper 'panel_sidebar_items', ->
	sidebarItens = {}
	objCollection = []
	objMenus = []
	userRole = Roles.getRolesForUser Meteor.userId()
	userMenus = PerfisAcesso.find({nome:userRole.toString()},{menu:1}).fetch()

	if typeof AdminConfig != 'undefined' and typeof AdminDashboard.sidebarItems == 'object'
		sidebarItens = AdminDashboard.sidebarItems

	_.each(_.pluck(userMenus, 'menu'), (fn) -> objMenus = fn)

	_.map sidebarItens, (obj, key) ->
		showMenu = false
		_.map obj.options.urls, (newObj, key) ->
			objCollection = [newObj.collection]

			intersec = (_.intersection(objCollection, objMenus))

			if _.isEmpty(intersec)
				newObj = _.extend newObj, {showItem: false}
			else
				newObj = _.extend newObj, {showItem: true, url:'/panel/'+objCollection}

			if newObj.showItem
				showMenu = true

		obj = _.extend obj, {showMenu: showMenu}
		return obj

UI.registerHelper 'panel_current_doc', ->
	Session.get 'panel_doc'

UI.registerHelper 'panel_collection_name', ->
	Session.get 'panel_collection_name'

UI.registerHelper 'panel_omit_fields', ->
	if typeof AdminConfig.autoForm != 'undefined' and typeof AdminConfig.autoForm.omitFields == 'object'
		global = AdminConfig.autoForm.omitFields
	if not Session.equals('panel_collection_name','Users') and typeof AdminConfig != 'undefined' and typeof AdminConfig.collections[Session.get 'panel_collection_name'].omitFields == 'object'
		collection = AdminConfig.collections[Session.get 'panel_collection_name'].omitFields
	if typeof global == 'object' and typeof collection == 'object'
		_.union global, collection
	else if typeof global == 'object'
		global
	else if typeof collection == 'object'
		collection
