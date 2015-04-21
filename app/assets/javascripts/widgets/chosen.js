var chosen_option = {
  allow_single_deselect: true,
  width: '100%'
}

$("select").livequery(function() { $(this).chosen(chosen_option); });
$(document).ready(function() {
  $("select").chosen(chosen_option);
});
$(document).on('page:load', function() {
  $("select").chosen(chosen_option);
})
