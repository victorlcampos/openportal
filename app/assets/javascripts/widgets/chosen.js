OpenPortal.ui.Chosen = function() {
  var chosen_option = {
    allow_single_deselect: true,
    width: '100%'
  };

  var init = function(element) {
    $(element).chosen(chosen_option);
    return {};
  }

  $(document).livequery('select', function() { init(this) });
  $(document).ready(function() { init('select') });

  return {init: init}
}();
