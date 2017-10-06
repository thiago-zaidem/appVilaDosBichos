Template.afArrayField_materialize.events({
    'click .autoform-add-item': function(){
        var divHeight = $('.autoform-object-field').height();
        $('html, body').animate({
            scrollTop: $(window).scrollTop() + divHeight
        }, 2000);
    }
});
