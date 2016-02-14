$(document).ready(function () {

  var $buttonAddStar = $('#button-add-star');
  var $formAddStar = $('#form-add-star');
  var $statusAddStar = $('#status-add-star');

  var $divMetadata = $('#div-metadata');
  var $formMetadata = $('#form-metadata');
  var $statusMetadata = $('#status-metadata');

  var $buttonAddMovie = $('#button-add-movie');
  var $formAddMovie = $('#form-add-movie');
  var $statusAddMovie = $('#status-add-movie');

  var $functionSelect = $('#dashboard-fn-select');
  var $dashboardFunctions = $('#dashboard-fns').children();

  $formAddStar.on('submit', function (e) {
    e.preventDefault();

    $buttonAddStar.prop('disabled', true);
    $statusAddStar.hide();

    $.post($formAddStar.attr('action'), $formAddStar.serialize())
      .done(function (data) {
        $formAddStar.trigger('reset');
        $statusAddStar
          .removeClass('bg-danger')
          .addClass('bg-success')
          .html(data)
          .show();
      })
      .fail(function (err) {
        $statusAddStar
          .removeClass('bg-success')
          .addClass('bg-danger')
          .html(err)
          .show();
      })
      .always(function () {
        $buttonAddStar.prop('disabled', false);
      });
  });

  $formMetadata.on('submit', function (e) {
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

  $formAddMovie.on('submit', function (e) {
    e.preventDefault();

    $buttonAddMovie.prop('disabled', true);
    $statusAddMovie.hide();

    $.post($formAddMovie.attr('action'), $formAddMovie.serialize())
      .done(function (data) {
        $formAddMovie.trigger('reset');
        $statusAddMovie
          .removeClass('bg-danger')
          .addClass('bg-success')
          .html(data)
          .show();
      })
      .fail(function (err) {
        $statusAddMovie
          .removeClass('bg-success')
          .addClass('bg-danger')
          .html(err.responseText)
          .show();
      })
      .always(function () {
        $buttonAddMovie.prop('disabled', false);
      });
  });

  $functionSelect.change(function (e) {
    $dashboardFunctions
      .hide()
      .eq(e.target.value)
      .show();
  });

  $functionSelect.change();
});
