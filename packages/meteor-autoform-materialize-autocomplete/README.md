tz:autoform-materialize-autocompelte
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
$ meteor add tz:autoform-materialize-autocomplete
```

## Usage

All avaiable parameters for Materialize chips can be defined in a SimpleSchema object.  Here's an example:

```coffee
Schema.Notes = new SimpleSchema
  ...
  tags:
    type: String
    label: "Local de atendimento"
    autoform:
      type: "materialize-autocomplete"
      placeholder: 'Buscar'
      materialIcon: 'search'
      addButton: true
      afFieldInput:
        limit: 1
        minLength: 1
        data: ->
          doc = ServiceLocation.find({"auditoria.deleted":false},{fields:{nome:1}}).fetch()
          obj = {}
          _.map doc, (key)->
            obj[key.nome] = null
          return obj
  ...
```
That's it.  Any field defined as type "materialize-autocomplete" will have full chips functionality within a `quickForm` or an `afQuickField`:


## Contributing

Anyone is welcome to contribute. Fork, make your changes, and then submit a pull request.
