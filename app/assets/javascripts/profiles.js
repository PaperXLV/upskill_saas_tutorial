/* global $, */
//Document ready
$(document).on('turbolinks:load', function() {
    var phone_field = $('#phone-input-field');
    phone_field.mask('(000) 000-0000');
    
    var about_me = $('#about-me-field')[0];
    var rows = about_me.rows;
    var prevtextlength = about_me.textLength;
    var currtextlength = prevtextlength;
    
    about_me.addEventListener('input', function() {
        about_me.rows = fitToContent(about_me, rows);
        rows = about_me.rows;
        prevtextlength = currtextlength;
    });
    
    
    function fitToContent(text, rows) {
        /* Accounts for rows being deleted, pixel value may need adjusting */
       /*if (text.height == text.scrollTop()) {
          text.height = "60px";
       }*/
      currtextlength = text.textLength;
      var adjustedRows = rows;
      if ((text.scrollHeight > text.clientHeight) && (currtextlength > prevtextlength)) {
          adjustedRows++;
      }
      /* TODO:: add the text to shrink back down
      else if ((text.scrollHeight == text.clientHeight) && (currtextlength < prevtextlength) && (rows > 3)) {
          adjustedRows--;
      }*/
      
      return adjustedRows;
    }
})