/* global $ */
//fadeout on alerts
$(document).on('turbolinks:load', function(){
  $('.alert').delay(1000).fadeOut(4000);
});