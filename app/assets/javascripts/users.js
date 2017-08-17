/* global $, Stripe */
//Document ready
$(document).on('turbolinks:load', function() {
    var proForm = $('#pro_form');
    var cenaForm = $('#cena_form');
    var submitBtn = $('#form-submit-btn')
    
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content') );

    submitBtn.click(function(event) {
        //prevent default submission behavior
        event.preventDefault();
        submitBtn.val("Processing").prop('disabled', true);
        
        var ccNum = $('#card_number').val(),
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
        
        //Use Stripe JS library to check for card errors.
        var error = false;
        
        //Validate card number
        if (!Stripe.card.validateCardNumber(ccNum)) {
            error = true;
            alert('The credit card number appears to be invalid');
        }
        
        if (!Stripe.card.validateCVC(cvcNum)) {
            error = true;
            alert('The cvc number appears to be invalid');
        }
        
        if (!Stripe.card.validateExpiry(expMonth, expYear)) {
            error = true
            alert('The expiration date appears to be invalid');
        }
        
        if (error) {
            submitBtn.prop('disabled', false).val("Submit");
        } 
        else {
            Stripe.createToken({
            number : ccNum, 
            cvc: cvcNum,
            exp_month: expMonth,
            exp_year: expYear
            }, stripeResponseHandler);
        }
        
        
        return false;
    });
    
    function stripeResponseHandler(status, response) {
        //Get token from response
        var token = response.id;
        
        //Inject the card token in a hidden field.
        //Differentiating because if cenaForm is found we need to use it, if proForm is found, we need to use it, and if its default, it doesn't matter
        if (cenaForm.length > proForm.length) {
            cenaForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
            cenaForm.get(0).submit();
        }
        else {
            proForm.append( $('<input type="hidden" name="user[stripe_card_token]">').val(token) );
            proForm.get(0).submit();
            
        }
    }
    //Stripe will return a card toekn.
    //Inject card token as hidden field into form.
    //Submit form to our rails app
});