// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require js-routes
//= require jquery-ui-map/jquery.ui.map
//= require markerwithlabel
//= require cocoon
//= require underscore
//= require backbone
//= require moment.min
//= require home

//$(document).on('click', '.js-add_linha', function(e) {
//    linha_id = $(this).data("linha");
//
//    $('#acessos_linhas_pontos').on('cocoon:after-insert', function(f, node) {
//        node.find(".js-linha_select").val(linha_id)
//        altera_itinerario()
//
//        $("#acessos_linhas_pontos").unbind("cocoon:after-insert");
//    })
//
//    $('.js-link_add_linha').trigger('click');
//
//    return false;
//})
//
//function preenche_dias(parent) {
//    linha_id = $(parent).find('.js-linha_select').val();
//
//    $.ajax({
//        url: Routes.linha_dias_path(linha_id),
//        dataType: 'json'
//    }).done(function(data) {
//        var dias = ''
//        data.forEach(function(dia) {
//            dias += "<option value='"+dia.id+"' "+ ( dia.today == true ? 'SELECTED' : '' ) +">"+dia.nome+"</option>"
//        });
//
//        $(parent).find('.js-dia_select').html(dias)
//
//        preenche_origens(parent);
//    });
//}
//
//function preenche_origens(parent) {
//    linha_id = $(parent).find('.js-linha_select').val();
//    dia_id = $(parent).find('.js-dia_select').val();
//
//    $.ajax({
//        url: Routes.linha_dia_pontos_path(linha_id, dia_id),
//        dataType: 'json'
//    }).done(function(data) {
//        var origens = ''
//        data.forEach(function(linha_ponto) {
//            origens += "<option value='"+linha_ponto.ponto.id+"'>"+linha_ponto.ponto.nome+"</option>"
//        });
//
//        $(parent).find('.js-origem_select').html(origens)
//
//        preenche_destinos(parent);
//    });
//}
//
//function preenche_destinos(parent) {
//    linha_id = $(parent).find('.js-linha_select').val();
//    dia_id = $(parent).find('.js-dia_select').val();
//    origem_id = $(parent).find('.js-origem_select').val();
//
//    $.ajax({
//        url: Routes.linha_dia_ponto_destinos_path(linha_id, dia_id, origem_id),
//        dataType: 'json'
//    }).done(function(data) {
//        var destinos = ''
//        data[0].destinos.forEach(function(linha_ponto) {
//            destinos += "<option value='"+linha_ponto.ponto.id+"'>"+linha_ponto.ponto.nome+"</option>"
//        });
//
//        $(parent).find('.js-destino_select').html(destinos)
//
//        preenche_horarios();
//    });
//}
//
//function preenche_horarios() {
//    var postData = $('#new_acesso').serializeArray();
//    var formURL = $('#new_acesso').attr("action");
//
//    $.ajax({
//        url: formURL,
//        data: postData,
//        type: 'POST'
//    }).done(function(data) {
//        $('#js-horario').html(data)
//    });
//}
//
//$(document).on('change', '.js-origem_select', function() {
//    parent = $(this).parents('.nested-fields')
//    preenche_destinos(parent);
//})
//
//$(document).on('change', '.js-dia_select', function() {
//    parent = $(this).parents('.nested-fields')
//    preenche_origens(parent);
//})
//
//$(document).on('change', '.js-linha_select', function() {
//    parent = $(this).parents('.nested-fields')
//    preenche_dias(parent);
//    altera_itinerario();
//})
//
//$(document).on('cocoon:after-remove', function(e, insertedItem) {
//    preenche_dias(insertedItem)
//    altera_itinerario()
//});
//
//$(document).on('cocoon:after-insert', function(e, insertedItem) {
//    preenche_dias(insertedItem)
//});
//
//$(document).ready(function() {
//    $('.nested-fields').each( function(index, parent) {
//        preenche_dias(parent);
//    });
//})
