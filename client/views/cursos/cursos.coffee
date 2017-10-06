Template.cursos.rendered = () ->
  $('.box-informacoes').hide()
  target = Router.current().params.query.k
  if target != ""
    $(".box-curso").hide()
    $('.box-detalhes-conteudo').show(->
      $('.box-detalhes-conteudo').fadeIn("slow")
    )
    $("#conteudo_"+target).show( ->
      $("#conteudo_"+target).fadeIn("slow")
    )

Template.cursos.events
  'click .more-btn': (e)->
    id = this._id
    $(".box-curso").hide()
    $('.box-detalhes-conteudo').show(->
      $('.box-detalhes-conteudo').fadeIn("slow")
    )
    $("#conteudo_"+id).show( ->
      $("#conteudo_"+id).fadeIn("slow")
    )

  'click .hideDetails': (e)->
    $(".box-curso-conteudo").hide()
    $('.box-informacoes').hide()
    $(".box-curso").show( ->
      $(".box-curso").fadeIn("slow")
    )

  'click .showInfo': (e)->
    $(".box-detalhes-conteudo").hide()
    $(".box-informacoes").show( ->
      $(".box-informacoes").fadeIn("slow")
    )