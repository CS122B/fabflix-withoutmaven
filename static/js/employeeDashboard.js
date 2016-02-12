$(document).ready(function () {

  var $buttonAddStar = $('#button-add-star');
  var $formAddStar = $('#form-add-star');
  var $statusAddStar = $('#status-add-star');

  var $divMetadata = $('#div-metadata');
  var $formMetadata = $('#form-metadata');
  var $statusMetadata = $('#status-metadata');

  $formAddStar.on('submit', function (e) {
    e.preventDefault();

    $buttonAddStar.prop('disabled', true);
    $statusAddStar.html('');

    $.post($formAddStar.attr('action'), $formAddStar.serialize())
      .done(function (data) {
        $formAddStar.trigger('reset');
        $statusAddStar
          .removeClass('bg-danger')
          .addClass('bg-success')
          .html(data);
      })
      .fail(function (err) {
        $statusAddStar
          .removeClass('bg-success')
          .addClass('bg-danger')
          .html(err);
      })
      .always(function () {
        $buttonAddStar.prop('disabled', false);
      });
  });

  $formMetadata.on('submit', function(e) {
    e.preventDefault();

    $.get($formMetadata.attr('action'))
      .done(function (data) {
        $divMetadata.html(data);
      })
      .fail(function (err) {
        $statusMetadata
          .removeClass('bg-success')
          .addClass('bg-danger')
          .html(err);
      });
  });
});
