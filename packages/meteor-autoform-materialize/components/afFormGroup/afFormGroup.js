Template.afFormGroup_materialize.helpers({
    addInputField: function() {
        var result, skipInputType, type;
        skipInputType = [
            'checkbox',
            'checkbox-group',
            'boolean-checkbox',
            'select-radio',
            'select-checkbox-inline',
            'select-radio-inline',
            'boolean-radios',
            'toggle',
            'switch'
        ];
        type = AutoForm.getInputType(this);
        result = !_.contains(skipInputType, type);
        return result;
    },
    skipLabel: function() {
        var result, skipLabelTypes, type;
        skipLabelTypes = [
            'checkbox',
            'checkbox-group',
            'boolean-checkbox',
            'boolean-radio',
            'toggle',
            'switch'
        ];
        type = AutoForm.getInputType(this);
        result = this.skipLabel || _.contains(skipLabelTypes, type);
        return result;
    },
    selectLabel: function() {
        var result, selectLabelType, type;
        selectLabelType = [
            'select-checkbox',
            'select-checkbox-inline',
            'select-radio',
            'select-radio-inline'
        ];
        type = AutoForm.getInputType(this);
        result = this.selectLabel || _.contains(selectLabelType, type);
        return result;
    },
	newRow: function() {
		var result;
		result = this.afFieldInputAtts.row;

		if(result == undefined){
			result = true;
		}
		return result;
	}
});

Template.afFormGroup_materialize.rendered = function() {
    var formId;
    formId = AutoForm.getFormId();
    this.autorun((function(_this) {
        return function() {
            var value = AutoForm.getFieldValue(_this.data.name, formId);
            var inputValue = AutoForm.getInputValue(_this.find('input'));
            var type = AutoForm.getInputType(_this.data);
            var placeholder = _this.data.afFieldInputAtts.placeholder;
            var divs = _this.$('div.line');
            var skipActiveLabelTypes = [
                'select',
                'checkbox',
                'checkbox-group',
                'boolean-checkbox',
                'boolean-radio',
                'toggle',
                'switch'
            ];
            var selectActiveLabelTypes = [
                'select-checkbox',
                'select-checkbox-inline',
                'select-radio',
                'select-radio-inline'
            ];

            for(var i=0; i<divs.length;) {
                i += divs.eq(i).nextUntil(':not(.line)').andSelf().wrapAll('<div class="row"/>').length;
            }

            if (!_.contains(skipActiveLabelTypes, type)) {
                if (!!value || !!inputValue || inputValue === 0 || !!placeholder) {
                    return _this.$('.input-field > label:not(:focus)').addClass('active');
                } else {
                    return _this.$('.input-field > label:not(:focus)').removeClass('active');
                }
            }

            /*if (_.contains(selectActiveLabelTypes, type)) {
                console.log(_this);
                return _this.$('label').addClass('select-label-active');
                if (!!value === 0 || !!placeholder) {
                    return _this.$('label').addClass('select-label-active');
                }
            }*/
        };
    })(this));
};
