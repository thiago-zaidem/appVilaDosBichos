Template.AdminDashboardViewWrapper.rendered = ->
	node = @firstNode

	@autorun ->
		data = Template.currentData()

		if data.view then Blaze.remove data.view
		while node.firstChild
			node.removeChild node.firstChild

		data.view = Blaze.renderWithData Template.AdminDashboardView, data, node

Template.AdminDashboardViewWrapper.destroyed = ->
	Blaze.remove @data.view

Template.AdminDashboardView.rendered = ->
	table = @$('.dataTable').DataTable();
	filter = @$('.dataTables_filter')
	length = @$('.dataTables_length')

	filter.html '
		<div class="input-group">
			<input type="search" class="form-control input-sm" placeholder="Search"></input>
			<div class="input-group-btn">
				<button class="btn btn-sm btn-default">
					<i class="fa fa-search"></i>
				</button>
			</div>
		</div>
	'

	length.html '
		<select class="form-control input-sm">
			<option value="10">10</option>
			<option value="25">25</option>
			<option value="50">50</option>
			<option value="100">100</option>
		</select>
	'

	filter.find('input').on 'keyup', ->
		table.search(@value).draw()

	length.find('select').on 'change', ->
		table.page.len(parseInt @value).draw()

Template.AdminDashboardView.helpers
	hasDocuments: ->
		AdminCollectionsCount.findOne({collection: Session.get 'admin_collection_name'})?.count > 0
	newPath: ->
		Router.path 'adminDashboard' + Session.get('admin_collection_name') + 'New'

Template.adminEditBtn.helpers
  path: ->
    Router.path "adminDashboard" + Session.get('admin_collection_name') + "Edit", _id: @_id
  isAction: (actionName) ->
    checkUserAction actionName, Meteor.userId()

Template.adminDeleteBtn.helpers
  isAction: (actionName) ->
    checkUserAction actionName, Meteor.userId()

Template.AdminSidebar.helpers
  isAction: (actionName) ->
    checkUserAction actionName, Meteor.userId()


#******************
# PANEL TEMPLATE
#******************
Template.PanelDashboardViewWrapper.rendered = ->
	node = @firstNode

	@autorun ->
		data = Template.currentData()

		if data.view then Blaze.remove data.view
		while node.firstChild
			node.removeChild node.firstChild

		data.view = Blaze.renderWithData Template.PanelDashboardView, data, node

Template.PanelDashboardViewWrapper.destroyed = ->
	Blaze.remove @data.view

Template.PanelDashboardView.rendered = ->
	table = @$('.dataTable').DataTable();
	filter = @$('.dataTables_filter')
	length = @$('.dataTables_length')

	filter.html '
		<div class="input-group">
			<input type="search" class="form-control input-sm" placeholder="Search"></input>
			<div class="input-group-btn">
				<button class="btn btn-sm btn-default">
					<i class="fa fa-search"></i>
				</button>
			</div>
		</div>
	'

	length.html '
		<select class="form-control input-sm">
			<option value="10">10</option>
			<option value="25">25</option>
			<option value="50">50</option>
			<option value="100">100</option>
		</select>
	'

	filter.find('input').on 'keyup', ->
		table.search(@value).draw()

	length.find('select').on 'change', ->
		table.page.len(parseInt @value).draw()

Template.PanelDashboardNew.rendered = ->
	$("input[name='dono']").val(Meteor.user().profile.nomeCompleto)
	$("input[name='dono']").prop('disabled', true)
	$("input[name='status']").prop('disabled', true)

Template.PanelDashboardEdit.rendered = ->
	$("input[name='dono']").prop('disabled', true)
	$("input[name='status']").prop('disabled', true)

Template.PanelDashboardView.helpers
	hasDocuments: ->
		PanelCollectionsCount.findOne({collection: Session.get 'panel_collection_name'})?.count > 0
	newPath: ->
		Router.path 'panelDashboard' + Session.get('panel_collection_name') + 'New'

Template.panelEditBtn.helpers
	path: ->
		Router.path "panelDashboard" + Session.get('panel_collection_name') + "Edit", _id: @_id
	isAction: (actionName) ->
		checkUserAction actionName, Meteor.userId()

Template.panelDeleteBtn.helpers
	isAction: (actionName) ->
		checkUserAction actionName, Meteor.userId()