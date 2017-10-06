Template.AdminLayout.created = function () {
  var self = this;

  self.minHeight = new ReactiveVar(
    $(window).height() - $('.main-header').height());

  $(window).resize(function () {
    self.minHeight.set($(window).height() - $('.main-header').height());
  });

    $('body').addClass('fixed');
    $('body').attr('id','admin');
};

Template.AdminLayout.destroyed = function () {
    $('body').removeClass('fixed');
    $('body').attr('id','home');
};

Template.AdminLayout.helpers({
  minHeight: function () {
    return Template.instance().minHeight.get() + 'px'
  }
});

Template.AdminSidebar.rendered = function () {
    $('.sidebar-collapse').slimScroll({
        color: '#888888',
        height: '350px',
        railOpacity: 0.9
    });
};

dataTableOptions = {
    "aaSorting": [],
    "bPaginate": true,
    "bLengthChange": false,
    "bFilter": true,
    "bSort": true,
    "bInfo": true,
    "bAutoWidth": false
};
