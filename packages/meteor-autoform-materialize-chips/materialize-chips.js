AutoForm.addInputType("materialize-chips", {
  template: "afMaterializeChips",
  valueIsArray: true,
  valueOut: function() {
    var ret = [];
    this.material_chip('data').forEach(function(data){
      ret.push(data.tag);
    });
    return ret;
  },
  valueIn: function(val) {
    var ret = [];
    for (var i = 0; i < val.length; i++) {
      ret.push({tag: val[i]});
    };
    return ret;
  }
});

Template.afMaterializeChips.helpers({
  atts: function() {
    return _.omit(this.atts, 'placeholder', 'secondaryPlaceholder', 'autocompleteOptions');
  }
})

Template.afMaterializeChips.onRendered(function() {
  var template = this;
  var params = this.data.atts;
  template.autorun(function () {
    var data = Template.currentData();
    template.$('.chips-autoform').material_chip({
      data: data.value,
      placeholder: params.placeholder,
      secondaryPlaceholder:  params.secondaryPlaceholder,
      autocompleteOptions: {
        limit: params.autocompleteOptions.limit,
        minLength: params.autocompleteOptions.minLength,
        data: params.autocompleteOptions.data()
      }
    });
  });
});
