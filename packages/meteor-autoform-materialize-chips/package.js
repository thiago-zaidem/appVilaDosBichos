Package.describe({
  name: 'dguedry:autoform-materialize-chips',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'Materialize Chips (Tags) input for Autoform',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/dguedry/autoform-materialize-chips.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.use(['aldeed:autoform@4.0.0 || 5.0.0',
          'templating',
          'blaze',
          'jquery'], 'client');
  api.addFiles([
    'materialize-chips.html',
    'materialize-chips.js'
  ], 'client');
});
