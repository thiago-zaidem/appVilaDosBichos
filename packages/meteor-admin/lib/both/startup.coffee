@AdminTables = {}

@PanelTables = {}

adminTablesDom = '<"box"<"box-header"<"box-toolbar"<"pull-left"<lf>><"pull-right"p>>><"box-body"t>>'

adminEditButton = (mode) -> {
  data: '_id'
  title: 'Editar'
  createdCell: (node, cellData, rowData) ->
    if mode == 'admin' or mode == '' or mode == undefined
      $(node).html(Blaze.toHTMLWithData Template.adminEditBtn, {_id: cellData}, node)
    else
      $(node).html(Blaze.toHTMLWithData Template.panelEditBtn, {_id: cellData}, node)
  width: '40px'
  orderable: false
}

adminDelButton = (mode) -> {
  data: '_id'
  title: 'Delete'
  createdCell: (node, cellData, rowData) ->
    if mode == 'admin' or mode == '' or mode == undefined
      $(node).html(Blaze.toHTMLWithData Template.adminDeleteBtn, {_id: cellData}, node)
    else
      $(node).html(Blaze.toHTMLWithData Template.panelDeleteBtn, {_id: cellData}, node)
  width: '40px'
  orderable: false
}

adminEditDelButtons = [
  adminEditButton('admin'),
  adminDelButton('admin')
]

defaultColumns = () -> [
  data: '_id',
  title: 'ID'
]

adminTablePubName = (collection) ->
  "admin_tabular_#{collection}"

panelTablePubName = (collection) ->
  "panel_tabular_#{collection}"

adminCreateTables = (collections,mode) ->
  _.each AdminConfig?.collections, (collection, name) ->
    _.defaults collection, {
      showEditColumn: true
      showDelColumn: true
    }

    columns = _.map collection.tableColumns, (column) ->
      if column.template
        createdCell = (node, cellData, rowData) ->
          $(node).html ''
          Blaze.renderWithData(Template[column.template], {value: cellData, doc: rowData}, node)

      data: column.name
      title: column.label
      render: (value)->
        if value instanceof Date
#console.log("data:"+value.toUTCString())
          moment(value).format('LLLL')
        else
          value
      createdCell: createdCell

    if columns.length == 0
      columns = defaultColumns()

    if collection.showEditColumn
      columns.push(adminEditButton(mode))
    if collection.showDelColumn
      columns.push(adminDelButton(mode))

    if mode == 'admin'
      AdminTables[name] = new Tabular.Table
        name: name
        collection: adminCollectionObject(name)
        pub: collection.children and adminTablePubName(name)
        sub: collection.sub
        columns: columns
        extraFields: collection.extraFields
        dom: adminTablesDom
        changeSelector: (selector,userId) ->
          #userRole = Roles.getRolesForUser userId
          #userMenus = PerfisAcesso.find({nome:userRole.toString()},{fields:{acoes:1}}).fetch()
          #acoes = userMenus[0].acoes
          #if acoes.indexOf('Editar_um') > 0
          if Roles.userIsInRole userId, ['admin']
            selector = 'auditoria.deleted':false
          else
            selector = 'auditoria.userCreate':userId
          selector
    else
      PanelTables[name] = new Tabular.Table
        name: 'PanelTable'+name
        collection: adminCollectionObject(name)
        pub: collection.children and panelTablePubName(name)
        sub: collection.sub
        columns: columns
        extraFields: collection.extraFields
        dom: adminTablesDom
        selector: (userId)->
          'auditoria.userCreate':userId

adminCreateRoutes = (collections) ->
  _.each collections, adminCreateRouteView
  _.each collections,	adminCreateRouteNew
  _.each collections, adminCreateRouteEdit

adminCreateRouteView = (collection, collectionName) ->
  Router.route "adminDashboard#{collectionName}View",
    adminCreateRouteViewOptions collection, collectionName

adminCreateRouteViewOptions = (collection, collectionName) ->
  options =
    path: "/admin/#{collectionName}"
    template: "AdminDashboardViewWrapper"
    controller: "AdminController"
    waitOn: ->
      subs.subscribe 'attachments'
      subs.subscribe 'profilePictures'
      if collection.joinCollection
        joins = collection.joinCollection
        for joinCollection in joins
          subs.subscribe joinCollection
    data: ->
      admin_table: AdminTables[collectionName]
    action: ->
      @render()
    onAfterAction: ->
      Session.set 'admin_title', AdminDashboard.collectionLabel collectionName
      Session.set 'admin_subtitle', 'Visualizar'
      Session.set 'admin_collection_name', collectionName
      collection.routes?.view?.onAfterAction
  _.defaults options, collection.routes?.view

adminCreateRouteNew = (collection, collectionName) ->
  Router.route "adminDashboard#{collectionName}New",
    adminCreateRouteNewOptions collection, collectionName

adminCreateRouteNewOptions = (collection, collectionName) ->
  options =
    path: "/admin/#{collectionName}/new"
    template: "AdminDashboardNew"
    controller: "AdminController"
    waitOn: ->
      if collection.joinCollection
        joins = collection.joinCollection
        for joinCollection in joins
          subs.subscribe joinCollection
    action: ->
      @render()
    onAfterAction: ->
      Session.set 'admin_title', AdminDashboard.collectionLabel collectionName
      Session.set 'admin_subtitle', 'Adicionar novo'
      Session.set 'admin_collection_page', 'new'
      Session.set 'admin_collection_name', collectionName
      collection.routes?.new?.onAfterAction
    data: ->
      admin_collection: adminCollectionObject collectionName
  _.defaults options, collection.routes?.new

adminCreateRouteEdit = (collection, collectionName) ->
  Router.route "adminDashboard#{collectionName}Edit",
    adminCreateRouteEditOptions collection, collectionName

adminCreateRouteEditOptions = (collection, collectionName) ->
  options =
    path: "/admin/#{collectionName}/:_id/edit"
    template: "AdminDashboardEdit"
    controller: "AdminController"
    waitOn: ->
      Meteor.subscribe 'adminCollectionDoc', collectionName, parseID(@params._id)
      collection.routes?.edit?.waitOn
    action: ->
      @render()
    onAfterAction: ->
      Session.set 'admin_title', AdminDashboard.collectionLabel collectionName
      Session.set 'admin_subtitle', 'Editar ' + @params._id
      Session.set 'admin_collection_page', 'edit'
      Session.set 'admin_collection_name', collectionName
      Session.set 'admin_id', parseID(@params._id)
      Session.set 'admin_doc', adminCollectionObject(collectionName).findOne _id : parseID(@params._id)
      collection.routes?.edit?.onAfterAction
    data: ->
      admin_collection: adminCollectionObject collectionName
  _.defaults options, collection.routes?.edit

adminPublishTables = (collections) ->
  _.each collections, (collection, name) ->
    if not collection.children then return undefined
    Meteor.publishComposite adminTablePubName(name), (tableName, ids, fields) ->
      check tableName, String
      check ids, Array
      check fields, Match.Optional Object

      extraFields = _.reduce collection.extraFields, (fields, name) ->
        fields[name] = 1
        fields
      , {}
      _.extend fields, extraFields

      @unblock()

      find: ->
        @unblock()
        adminCollectionObject(name).find {_id: {$in: ids}}, {fields: fields}
      children: collection.children

panelCreateRoutes = (collections) ->
  _.each collections, panelCreateRouteView
  _.each collections, panelCreateRouteNew
  _.each collections, panelCreateRouteEdit

panelCreateRouteView = (collection, collectionName) ->
  Router.route "panelDashboard#{collectionName}View",
    panelCreateRouteViewOptions collection, collectionName

panelCreateRouteViewOptions = (collection, collectionName) ->
  options =
    path: "/panel/#{collectionName}"
    template: "PanelDashboardViewWrapper"
    controller: "PanelController"
    waitOn: ->
      subs.subscribe 'attachments'
      subs.subscribe 'profilePictures'
    data: ->
      panel_table: PanelTables[collectionName]
    action: ->
      @render()
    onAfterAction: ->
      Session.set 'panel_title', AdminDashboard.collectionLabel collectionName
      Session.set 'panel_subtitle', 'Visualizar'
      Session.set 'panel_collection_name', collectionName
      collection.routes?.view?.onAfterAction
  _.defaults options, collection.routes?.view

panelCreateRouteNew = (collection, collectionName) ->
  Router.route "panelDashboard#{collectionName}New",
    panelCreateRouteNewOptions collection, collectionName

panelCreateRouteNewOptions = (collection, collectionName) ->
  options =
    path: "/panel/#{collectionName}/new"
    template: "PanelDashboardNew"
    controller: "PanelController"
    action: ->
      @render()
    onAfterAction: ->
      Session.set 'panel_title', AdminDashboard.collectionLabel collectionName
      Session.set 'panel_subtitle', 'Adicionar novo'
      Session.set 'panel_collection_page', 'new'
      Session.set 'panel_collection_name', collectionName
      collection.routes?.new?.onAfterAction
    data: ->
      panel_collection: adminCollectionObject collectionName
  _.defaults options, collection.routes?.new

panelCreateRouteEdit = (collection, collectionName) ->
  Router.route "panelDashboard#{collectionName}Edit",
    panelCreateRouteEditOptions collection, collectionName

panelCreateRouteEditOptions = (collection, collectionName) ->
  options =
    path: "/panel/#{collectionName}/:_id/edit"
    template: "PanelDashboardEdit"
    controller: "PanelController"
    waitOn: ->
      Meteor.subscribe 'adminCollectionDoc', collectionName, parseID(@params._id)
      collection.routes?.edit?.waitOn
    action: ->
      @render()
    onAfterAction: ->
      Session.set 'panel_title', AdminDashboard.collectionLabel collectionName
      Session.set 'panel_subtitle', 'Editar ' + @params._id
      Session.set 'panel_collection_page', 'edit'
      Session.set 'panel_collection_name', collectionName
      Session.set 'panel_id', parseID(@params._id)
      Session.set 'panel_doc', adminCollectionObject(collectionName).findOne _id : parseID(@params._id)
      collection.routes?.edit?.onAfterAction
    data: ->
      panel_collection: adminCollectionObject collectionName
  _.defaults options, collection.routes?.edit

Meteor.startup ->
  adminCreateTables AdminConfig?.collections,'admin'
  adminCreateTables AdminConfig?.collections,'panel'
  adminCreateRoutes AdminConfig?.collections
  adminPublishTables AdminConfig?.collections if Meteor.isServer

  panelCreateRoutes AdminConfig?.collections

  if AdminTables.Users then return undefined

  AdminTables.Users = new Tabular.Table
  # Modify selector to allow search by email
    changeSelector: (selector, userId) ->
      $or = selector['$or']
      $or and selector['$or'] = _.map $or, (exp) ->
        if exp.emails?['$regex']?
          emails: $elemMatch: address: exp.emails
        else
          exp
      selector

    name: 'Users'
    collection: Meteor.users
    columns: _.union [
      {
        data: '_id'
        title: 'Admin'
        # TODO: use `tmpl`
        createdCell: (node, cellData, rowData) ->
          $(node).html(Blaze.toHTMLWithData Template.adminUsersIsAdmin, {_id: cellData}, node)
        width: '40px'
      }
      {
        data: 'emails'
        title: 'E-mail'
        render: (value) ->
          value[0].address
        searchable: true
      }
      {
        data: 'emails'
        title: 'Enviar e-mail'
        # TODO: use `tmpl`
        createdCell: (node, cellData, rowData) ->
          $(node).html(Blaze.toHTMLWithData Template.adminUsersMailBtn, {emails: cellData}, node)
        width: '40px'
      }
      {
        data: 'createdAt'
        title: 'Adicionado'
        render: (value)->
          moment(value).format('LLLL')
      }
      { data: 'roles', title: 'Perfil de Acesso' }
    ], adminEditDelButtons
    dom: adminTablesDom
