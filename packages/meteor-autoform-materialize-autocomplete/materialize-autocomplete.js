AutoForm.addInputType("materialize-autocomplete", {
    template: "afMaterializeAuc",
    valueIsArray: false,
    valueOut: function() {
        this.val = this.context.value;
        return this.val;
    }
});

Template.afMaterializeAuc.helpers({
    atts: function() {
        return _.omit(this.atts,'addButton', 'materialIcon', 'limit', 'minLength', 'data');
    },
	icon: function() {
		return this.atts.materialIcon	
	},
	addButton: function() {
		return this.atts.addButton	
	},
    value: function() {
        return this.value[0];
    }
})

Template.afMaterializeAuc.onRendered(function() {
    var template = this;
    var params = this.data.atts;
    template.autorun(function () {
        var data = Template.currentData();
        template.$('input.autocomplete-autoform').autocomplete({
            data: params.data,
            placeholder: params.placeholder,
            limit: params.limit,
            minLength: params.minLength
        });
    });
	if(params.materialIcon) {
		$('input.autocomplete-autoform').addClass('icon');
	}
});
