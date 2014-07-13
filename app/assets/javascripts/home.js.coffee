#= require ./backbone/tcgl_server
#= require_tree ./backbone/models
#= require_tree ./backbone/collections
#= require_tree ./backbone/views

$ ->
  tcglServer.start()

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.

#linhas_id = ->
#  ids = new Array()
#  $.each $(".js-linha_select:visible"), (index, linha) ->
#    ids.push $(linha).val()
#    return
#
#  ids
#poll = ->
#  setTimeout (->
#    $.ajax
#      url: Routes.positions_lines_path()
#      data:
#        "linhas_id[]": linhas_id()
#
#      type: "POST"
#      dataType: "json"
#      success: (data) ->
#        add_markers data
#        poll()
#        return
#
#    return
#  ), 10000
#  return
#add_markers = (posicoes) ->
#  markers.forEach (marker) ->
#    marker.setMap null
#    return
#
#  markers = []
#  posicoes.forEach (posicao) ->
#    markers[posicao.id] = new MarkerWithLabel(
#      map: map
#      position: new google.maps.LatLng(posicao.lat, posicao.lng)
#      labelContent: (posicao.linha.nome + " <br>Para: " + posicao.para)
#      labelAnchor: new google.maps.Point(0, 0)
#      labelClass: "label-marker" # the CSS class for the label
#      labelStyle:
#        opacity: 0.75
#    )
#    return
#
#  return
#altera_itinerario = ->
#  itinerarios.forEach (itinerario) ->
#    itinerario.setMap null
#    return
#
#  itinerarios = []
#  $.ajax(
#    url: Routes.itineraries_lines_path()
#    data:
#      "linhas_id[]": linhas_id()
#
#    type: "POST"
#    dataType: "json"
#  ).done (data) ->
#    $.ajax
#      url: Routes.positions_lines_path()
#      data:
#        "linhas_id[]": linhas_id()
#
#      type: "POST"
#      dataType: "json"
#      success: (data) ->
#        add_markers data
#        return
#
#    $.each data, (index1, itinerario_linhas) ->
#      $.each itinerario_linhas, (index2, itinerario_sentidos) ->
#        itinerarios_ida = []
#        $.each itinerario_sentidos, (index3, itinerario) ->
#          itinerarios_ida.push new google.maps.LatLng(itinerario.lat, itinerario.lng)
#          color = itinerario.color
#          return
#
#        itinerarios.push new google.maps.Polyline(
#          map: map
#          path: itinerarios_ida
#          strokeColor: color
#          strokeWeight: 2
#        )
#        return
#
#      return
#
#    return
#
#  return
#initialize = ->
#  myOptions =
#    zoom: 14
#    maxZoom: 16
#    minZoom: 1
#    streetViewControl: false
#    center: new google.maps.LatLng(-23.307895, -51.161442)
#    mapTypeId: google.maps.MapTypeId.ROADMAP
#
#  map = new google.maps.Map(document.getElementById("map-canvas"), myOptions)
#  poll()
#  altera_itinerario()
#  google.maps.event.addListener map, "dblclick", (mEvent) ->
#    unless marker_ida?
#      marker_ida = new MarkerWithLabel(
#        map: map
#        position: mEvent.latLng
#        labelContent: ("Partida")
#        labelAnchor: new google.maps.Point(0, 0)
#        labelClass: "label-marker" # the CSS class for the label
#        draggable: true
#        labelStyle:
#          opacity: 0.75
#      )
#      calcula_partida()
#      google.maps.event.addListener marker_ida, "dragend", ->
#        calcula_partida()
#        return
#
#    else unless marker_volta?
#      marker_volta = new MarkerWithLabel(
#        map: map
#        position: mEvent.latLng
#        labelContent: ("Chegada")
#        labelAnchor: new google.maps.Point(0, 0)
#        labelClass: "label-marker" # the CSS class for the label
#        draggable: true
#        labelStyle:
#          opacity: 0.75
#      )
#      calcula_chegada()
#      google.maps.event.addListener marker_volta, "dragend", ->
#        calcula_chegada()
#        return
#
#    return
#
#  return
#calcula_partida = ->
#  unless circle_ida is `undefined`
#    circle_ida.setMap null
#  else
#    $("#map-canvas").parent(".col-md-12").removeClass("col-md-12").addClass "col-md-9"
#    $(".js-onibus_partida_chegada").removeClass "hidden"
#  $.ajax
#    url: Routes.departures_lines_path()
#    data:
#      posicao_partida:
#        lat: marker_ida.getPosition().lat()
#        lng: marker_ida.getPosition().lng()
#
#    dataType: "json"
#    method: "POST"
#    success: (data) ->
#      circle_ida = new google.maps.Circle(
#        strokeColor: "#FF0000"
#        strokeOpacity: 0.8
#        strokeWeight: 2
#        fillColor: "#FF0000"
#        fillOpacity: 0.35
#        map: map
#        center: marker_ida.getPosition()
#        radius: data["distancia"] * 1000
#      )
#      linhas_partidas = ""
#      data["itinerario"].forEach (linha) ->
#        linhas_partidas += "<a href=\"#\" class=\"js-add_linha\" data-linha=\"" + linha.id + "\"><icon class=\"fa fa-plus\"></i></a> " + linha.codigo_nome + "<br />"
#        return
#
#      $(".js-onibus_partida").html linhas_partidas
#      return
#
#  return
#calcula_chegada = ->
#  circle_volta.setMap null  unless circle_volta is `undefined`
#  $.ajax
#    url: Routes.arrivals_lines_path()
#    data:
#      posicao_partida:
#        lat: marker_ida.getPosition().lat()
#        lng: marker_ida.getPosition().lng()
#
#      posicao_chegada:
#        lat: marker_volta.getPosition().lat()
#        lng: marker_volta.getPosition().lng()
#
#    dataType: "json"
#    method: "POST"
#    success: (data) ->
#      circle_volta = new google.maps.Circle(
#        strokeColor: "#FF0000"
#        strokeOpacity: 0.8
#        strokeWeight: 2
#        fillColor: "#FF0000"
#        fillOpacity: 0.35
#        map: map
#        center: marker_volta.getPosition()
#        radius: data["distancia"] * 1000
#      )
#      linhas_chegadas = ""
#      data["itinerario"].forEach (linha) ->
#        linhas_chegadas += "<a href=\"#\" class=\"js-add_linha\" data-linha=\"" + linha.id + "\"><icon class=\"fa fa-plus\"></i></a> " + linha.codigo_nome + "<br />"
#        return
#
#      $(".js-onibus_chegada").html linhas_chegadas
#      return
#
#  return
#
#markers = []
#itinerarios = []
#map = undefined
#marker_ida = undefined
#marker_volta = undefined
#circle_ida = undefined
#circle_volta = undefined
#window.onload = initialize