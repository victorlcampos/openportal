OpenPortal.ui.Tile = function() {
  var init = function(element) {
    var tileName = $(element).data('tile-name');

    $.get('tiles/'+tileName, function(data) {
      $(element).html(data);
    });

    return {};
  }

  return {init: init}
}();
