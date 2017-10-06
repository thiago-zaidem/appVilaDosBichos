Package.describe({
  name: "yogiben:admin",
  summary: "A complete admin dashboard solution",
  version: "1.2.3",
  git: "https://github.com/yogiben/meteor-admin"
});

Package.on_use(function(api){

  both = ['client','server']

  api.versionsFrom('METEOR@1.0');

  api.use(
    ['iron:router',
    'coffeescript',
    'underscore',
    'reactive-var',
    'aldeed:collection2',
    'aldeed:autoform',
    'aldeed:template-extension',
    'alanning:roles',
    'raix:handlebar-helpers',
    'reywood:publish-composite',
    'momentjs:moment',
    'aldeed:tabular',
    'meteorhacks:unblock',
    'zimme:active-route',
    'mfactory:admin-lte',
    'gildaspk:autoform-materialize'
    ],
    both);

  api.use(['less@1.0.0 || 2.5.0','session','jquery','templating'],'client')

  api.use(['email'],'server')

  api.add_files([
    'lib/both/AdminDashboard.coffee',
    'lib/both/router.coffee',
    'lib/both/utils.coffee',
    'lib/both/startup.coffee',
    'lib/both/collections.coffee'
    ], both);

  api.add_files([
    'lib/client/html/admin_templates.html',
    'lib/client/html/admin_widgets.html',
    'lib/client/html/admin_layouts.html',
    'lib/client/html/admin_sidebar.html',
    'lib/client/html/admin_header.html',
    'lib/client/html/panel_layouts.html',
    'lib/client/html/panel_templates.html',
    'lib/client/css/admin-custom.less',
    'lib/client/js/admin_layout.js',
    'lib/client/js/helpers.coffee',
    'lib/client/js/templates.coffee',
    'lib/client/js/events.coffee',
    'lib/client/js/slim_scroll.js',
    'lib/client/js/autoForm.coffee'
    ], 'client');

  api.add_files([
    'lib/server/publish.coffee',
    'lib/server/methods.coffee'
    ], 'server');

  api.export('AdminDashboard',both)
});
