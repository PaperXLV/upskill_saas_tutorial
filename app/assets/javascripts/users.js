/* global $, Stripe */
//Document ready
$(document).on('turbolinks:load', function() {
    var proForm = $('#pro_form');
    var cenaForm = $('#cena_form');
    var submitBtn = $('#form-submit-btn')
    
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

    submitBtn.click(function(event)) {
        //prevent default submission behavior
        event.preventDefault();
        
        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
        
        Stripe.createToken({
            number : ccNum, 
            cvc: cvcNum,
            exp_month: expMonth,
            exp_year: expYear
        }, stripeResponseHandler);
    }
    //Stripe will return a card toekn.
    //Inject card token as hidden field into form.
    //Submit form to our rails app
});