dguedry:autoform-materialize-chips
=========================

An add-on Meteor package for [aldeed:autoform](https://github.com/aldeed/meteor-autoform). Provides a custom input type for Materialize chips (tags) (http://materializecss.com/chips.html.

## Prerequisites

### AutoForm

In a Meteor app directory, enter:

```bash
$ meteor add aldeed:autoform
```

### A materialize package

There are several materialize packages available.  I used the official materialize:materialize:

```
meteor add materialize:materialize
```

## Installation

In a Meteor app directory, enter:

```bash
$ meteor add dguedry:autoform-materialize-chips
```

## Usage

All avaiable parameters for Materialize chips can be defined in a SimpleSchema object.  Here's an example:

```js
Schema.Notes = new SimpleSchema({
  ...
  tags: {
    type: [String],
    autoform: {
      type: "materialize-chips",
      afFieldInput: {
        placeholder: '+Tag',
        secondaryPlaceholder: 'Add tag(s)',
        autocompleteOptions: {
          limit: Infinity,
          minLength: 0,
          data: function() {return {'Apple': null,'Microsoft': null,'Google': null}}
        }
      }
    }
  },
  ...
```
That's it.  Any field defined as type "materialize-chips" will have full chips functionality within a `quickForm` or an `afQuickField`:


## Contributing

Anyone is welcome to contribute. Fork, make your changes, and then submit a pull request.
