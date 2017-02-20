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

  selectAll('#due_select_all_members', '[type="checkbox"][name="due[member_ids][]"]');
  selectAll('#member_select_all_dues', '[type="checkbox"][name="member[due_ids][]"]');

  // Given a number of checkboxes identified with checkboxes_selector exist
  // and a 'select all' checkbox (select_all_selector) exist
  // track checkboxes state and check/uncheck
  function selectAll(select_all_selector, checkboxes_selector) {
    function checkSelectAll() {
      var select_all_checked = $(checkboxes_selector).length ==
        $(checkboxes_selector + ':checked').length;
      $(select_all_selector).prop('checked', select_all_checked);
    }
    checkSelectAll();
    $(select_all_selector).change(function(e) {
      $(checkboxes_selector).prop("checked", e.target.checked)
    });
    $(checkboxes_selector).change(function() {
      checkSelectAll();
    });
  }

  // Open KPO in a new window for printing
  if ($('#print_payment_link').length > 0) {
    window.open(
      $('#print_payment_link').attr("href"),
      'Print',
      'fullscreen=1'
    )
  }

});
