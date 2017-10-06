@PanelController = RouteController.extend
  layoutTemplate: 'PanelLayout'
  waitOn: ->
    [
      Meteor.subscribe 'RolesProfile'
      Meteor.subscribe 'attachments'
      Meteor.subscribe 'profilePictures'
    ]
  onBeforeAction: ->
    Session.set 'adminSuccess', null
    Session.set 'adminError', null

    Session.set 'panel_title', ''
    Session.set 'panel_subtitle', ''
    Session.set 'panel_collection_page', null
    Session.set 'panel_collection_name', null
    Session.set 'panel_id', null
    Session.set 'panel_doc', null

    @next()

@AdminController = RouteController.extend
  layoutTemplate: 'AdminLayout'
  waitOn: ->
    [
      Meteor.subscribe 'adminUsers'
      Meteor.subscribe 'adminUser'
      Meteor.subscribe 'adminCollectionsCount'
      Meteor.subscribe 'RolesProfile'
      Meteor.subscribe 'attachments'
      Meteor.subscribe 'profilePictures'
    ]
  onBeforeAction: ->
    Session.set 'adminSuccess', null
    Session.set 'adminError', null

    Session.set 'admin_title', ''
    Session.set 'admin_subtitle', ''
    Session.set 'admin_collection_page', null
    Session.set 'admin_collection_name', null
    Session.set 'admin_id', null
    Session.set 'admin_doc', null

    if not Roles.userIsInRole Meteor.userId(), ['admin']
      Meteor.call 'adminCheckAdmin'
      if typeof AdminConfig?.nonAdminRedirectRoute == 'string'
        Router.go AdminConfig.nonAdminRedirectRoute

    @next()

Router.route "panelDashboard",
  path: "/panel"
  template: "PanelDashboard"
  controller: "PanelController"
  action: ->
    @render()
  onAfterAction: ->
    Session.set 'panel_title', 'Painel Administativo'
    Session.set 'panel_collection_name', ''
    Session.set 'panel_collection_page', ''

Router.route "adminDashboard",
  path: "/admin"
  template: "AdminDashboard"
  controller: "AdminController"
  action: ->
    @render()
  onAfterAction: ->
    Session.set 'admin_title', 'Painel Administativo'
    Session.set 'admin_subtitle', AdminConfig.dashboard.adminVersion
    Session.set 'admin_collection_name', ''
    Session.set 'admin_collection_page', ''

Router.route "adminDashboardUsersView",
  path: "/admin/Users"
  template: "AdminDashboardView"
  controller: "AdminController"
  action: ->
    @render()
  data: ->
    admin_table: AdminTables.Users
  onAfterAction: ->
    Session.set 'admin_title', 'Users'
    Session.set 'admin_subtitle', 'Visualizar'
    Session.set 'admin_collection_name', 'Users'

Router.route "adminDashboardUsersNew",
  path: "/admin/Users/new"
  template: "AdminDashboardUsersNew"
  controller: 'AdminController'
  action: ->
    @render()
  onAfterAction: ->
    Session.set 'admin_title', 'Users'
    Session.set 'admin_subtitle', 'Criar novo usuário'
    Session.set 'admin_collection_page', 'New'
    Session.set 'admin_collection_name', 'Users'

Router.route "adminDashboardUsersEdit",
  path: "/admin/Users/:_id/edit"
  template: "AdminDashboardUsersEdit"
  controller: "AdminController"
  data: ->
    user: Meteor.users.find(@params._id).fetch()
    roles: Roles.getRolesForUser @params._id
    #otherRoles: _.difference _.map(Meteor.roles.find().fetch(), (role) -> role.name), Roles.getRolesForUser(@params._id)
    otherRoles: _.difference _.map(PerfisAcesso.find().fetch(), (role) -> role.nome), Roles.getRolesForUser(@params._id)
  action: ->
    @render()
  onAfterAction: ->
    Session.set 'admin_title', 'Users'
    Session.set 'admin_subtitle', 'Editar usuário ' + @params._id
    Session.set 'admin_collection_page', 'edit'
    Session.set 'admin_collection_name', 'Users'
    Session.set 'admin_id', @params._id
    Session.set 'admin_doc', Meteor.users.findOne({_id:@params._id})
