/* global $, */
//Document ready
$(document).on('turbolinks:load', function() {
    var phone_field = $('#phone-input-field');
    phone_field.mask('(000) 000-0000');
})