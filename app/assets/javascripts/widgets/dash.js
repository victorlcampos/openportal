OpenPortal.ui.Dash = function() {
  var init = function(element) {
    $(element).addClass('gridster');
    $(element).find('ul').gridster({
        widget_margins: [10, 10],
        widget_base_dimensions: [140, 140]
    });

    return {};
  }

  return {init: init}
}();
