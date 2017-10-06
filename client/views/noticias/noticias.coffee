Template.noticias.rendered = ()->
  target = Router.current().params.query.k
  ###
  if target !""
    $('html, body').animate({
      scrollTop: $("#"+target).offset().top-80
    }, 1000)

###

Template.noticias.events
  'click .more': (e)->
    id = this._id
    if $(".vagaDesc_"+id).is(":hidden")
      $(".vagaDesc_"+id).show(->
        $(".vagaDesc_"+id).slideDown("slow")
      )
      $(".nivel_"+id).hide(->
        $(".nivel_"+id).slideUp("slow")
      )
      $('#more_'+id).html("<a hfer='#' alt='mais'><i class='fa fa-angle-up fa-3x'></i></a>")
    else
      $(".vagaDesc_"+id).hide(->
        $(".vagaDesc_"+id).slideUp("slow")
      )
      $(".nivel_"+id).show(->
        $(".nivel_"+id).slideDown("slow")
      )
      $('#more_'+id).html("<a hfer='#' alt='mais'><i class='fa fa-angle-down fa-3x'></i></a>")