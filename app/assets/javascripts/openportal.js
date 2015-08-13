// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require chosen-jquery
//= require cocoon
//= require_tree ./vendor
//= require_self
//= require_tree ./widgets
//= require turbolinks

var OpenPortal = {};
OpenPortal.ui  = {};

var initModules = function() {
  $(document).livequery('[data-ui-module]', function() {
    OpenPortal.ui[$(this).data('ui-module')].init(this);
  });
}

$(document).ready(function() { initModules(); });
