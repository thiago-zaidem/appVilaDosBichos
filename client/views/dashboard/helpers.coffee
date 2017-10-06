dashboardCollections = ->
	collections = {}
	widget = false

	if typeof DashboardConfig != 'undefined' and typeof DashboardConfig.collections == 'object'
		collections = DashboardConfig.collections

	_.map collections, (obj, key) ->
		count = 0
		mObj = Meteor.Collection.get(obj.meteorCollection).find({userId:Meteor.userId()}).fetch()
		obj = _.extend obj, {name: key}
		obj = _.defaults obj, {label: key, icon: 'plus', color: 'blue', sidebar: false, widget: widget, panel: false}
		_.map mObj[0], (value,k) ->
			if k == obj.columnCount
				if obj.subColumnCount != undefined
					_.map value, (val) ->
						count = val.length
				else
					count += 1
		obj = _.extend obj, {count:count}

UI.registerHelper 'dashboard_collections', dashboardCollections

UI.registerHelper 'dashboardGetCollection', (collection)->
	_.find dashboardCollections(), (item) -> item.name == collection