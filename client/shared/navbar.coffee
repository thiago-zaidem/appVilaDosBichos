Template.navbar.rendered = () ->
	$(".dropdown-button").dropdown({
		inDuration: 300
		outDuration: 225
		constrain_width: false #Does not change width of dropdown to that of the activator
		hover: true #Activate on hover
		gutter: 0 #Spacing from edge
		belowOrigin: true #Displays dropdown below the button
	})

Template.navbar.events
  'click .dropdown-toggle': ->
    #$('.dropdown-toggle i').removeClass('fa-angle-left')
    #$('.dropdown-menu', '.dropdown-toggle').stop(true, true).fadeIn 'fast'
    #console.log($('.dropdown-toggle i'))

###
  $('.dropdown-toggle').click (->
    console.log("navbar-drop")
    $('.dropdown-menu', this).stop(true, true).fadeIn 'fast'
    $(this).toggleClass 'open'
    $('b', this).toggleClass 'caret caret-up'
    return
  ), ->
    $('.dropdown-menu', this).stop(true, true).fadeOut 'fast'
    $(this).toggleClass 'open'
    $('b', this).toggleClass 'caret caret-up'
    return

###

Template.navbarSite.rendered = () ->
	$(".dropdown-button").dropdown({
			inDuration: 300
			outDuration: 225
			constrain_width: false #Does not change width of dropdown to that of the activator
			hover: true #Activate on hover
			gutter: 0 #Spacing from edge
			belowOrigin: true #Displays dropdown below the button
  })

Template.userFullName.helpers
  fullName: ->
    return Meteor.user().profile.nomeCompleto