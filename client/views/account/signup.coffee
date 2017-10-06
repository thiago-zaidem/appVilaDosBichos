Template['override-fullPageAtForm'].replaces('fullPageAtForm')
Template['override-atPwdForm'].replaces('atPwdForm')
Template['override-atTextInput'].replaces('atTextInput')
Template['override-atPwdFormBtn'].replaces('atPwdFormBtn')

Template.atForm.rendered = () ->
  $("body").attr('style','background:url(/img/bg-login.png)')
  $("#at-label-email").text("perm_identity");
  $("#at-label-password").text("lock_outline");
  $(".at-title").addClass("text-center");
  
