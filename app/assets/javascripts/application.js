// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

document.addEventListener("turbolinks:load", function() {

  // Adds a new nested form
  // Finds all links with data-form-prepend (which contains the form to add)
  // changes name to timesstamp
  // and appends it to the element from data-target
  $('[data-form-prepend]').click( function(e) {
      var obj = $( $(this).attr('data-form-prepend') );
      obj.find('input, select, textarea').each( function() {
        $(this).attr( 'name', function() {
          return $(this).attr('name').replace( 'new_record', (new Date()).getTime() );
        });
      });
      var target = $($(this).attr('data-target'));
      target.append(obj);
      return false;
    });

});
