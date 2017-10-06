@adminCollectionObject = (collection) ->
	if typeof AdminConfig.collections[collection] != 'undefined' and typeof AdminConfig.collections[collection].collectionObject != 'undefined'
		AdminConfig.collections[collection].collectionObject
	else
		lookup collection

@adminCallback = (name, args, callback) ->
	stop = false
	if typeof AdminConfig?.callbacks?[name] == 'function'
		stop = AdminConfig.callbacks[name](args...) is false
	if typeof callback == 'function'
		callback args... unless stop

@lookup = (obj, root, required=true) ->
	if typeof root == 'undefined'
		root = if Meteor.isServer then global else window
	if typeof obj == 'string'
		ref = root
		arr = obj.split '.'
		continue while arr.length and (ref = ref[arr.shift()])
		if not ref and required
			throw new Error(obj + ' is not in the ' + root.toString())
		else
			return ref
	return obj
	
@parseID = (id) ->
	if typeof id == 'string'
		if(id.indexOf("ObjectID") > -1)
			return new Mongo.ObjectID(id.slice(id.indexOf('"') + 1,id.lastIndexOf('"')))
		else
			return id
	else
		return id

@parseIDs = (ids) ->
    return _.map ids, (id) ->
        parseID id

@checkUserAction = (actionName, userId) ->
  objAcoes = []
  userRole = Roles.getRolesForUser userId
  userMenus = PerfisAcesso.find({nome:userRole.toString()},{menu:1}).fetch()

  if Roles.userIsInRole userId, ['admin']
    return true
  else
    _.each(_.pluck(userMenus, 'acoes'), (fn) -> objAcoes = fn)

    if _.find(objAcoes,(e)-> e == actionName) == undefined
      #console.log("Você não tem permissão para " + actionName)
      return false
    else
      #console.log("Você tem permissão para " + actionName)
      return true

@createDefaultProfiles = (user) ->
	#cria os perfis de acesso de acordo com arquivo de configuraçao _config - Config.profileDashboard
	profileDashbord = Config.profileDashboard

	_.map profileDashbord,  (key)->
		perfilAcesso = PerfisAcesso.find({nome:key,"auditoria.deleted":false},{fields:{nome:1}}).fetch()
		if perfilAcesso is undefined or "" or []
			if key == 'admin'
				acoes = ["Inserir","Editar","Apagar","Visualizar"]
				collections = {}
				collections = AdminConfig.collections
				menus = []
				_.map(collections, (obj, key) ->
					menus.push key
				)
				user.profile = ['admin']
			else
				acoes = ["Visualizar"]
				menus = [""]
			PerfisAcesso.insert({nome:key, menu:menus, acoes:acoes})