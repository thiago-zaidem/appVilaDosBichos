Template.afLabel_materialize.helpers({
  atts: function() {
    var labelAtts;
    var labelClass;

    labelClass = this.afFieldInputAtts.labelClass;
    labelAtts = this.afFieldLabelAtts;

    if (labelClass != undefined)
      labelAtts = _.extend (labelAtts,{class:labelClass});

    return labelAtts;
  }
});
