$(document).ready(function () {

  var $form = $('.form-horizontal .form-control');
  var $inputs = $form.filter('input');
  var $selects = $form.filter('select');
  $('#search-reset').click(function () {
    $inputs.val('');
    $selects.val('none');
  });

  var $modalAddMovie = $('#modal-add-movie');
  var $modalMovieMessage = $('#modal-movie-message');

  $('.button-add-movie').click(function (/* e */) {
    var $that = $(this);

    $that
      .prop('disabled', true)
      .html('Add to Cart');

    var movieId = $that
      .attr('data-movie-id')
      .replace(/\s/g, '');

    var movieTitle = $that
      .attr('data-movie-title');

    var movieYear = $that
      .attr('data-movie-year')
      .replace(/\s/g, '');

    var postData = {
      movieId: movieId,
      quantity: 1
    };

    $.post('/fabflix/servlet/user/addToCart', postData)
      .done(function (data) {
        $modalMovieMessage.html(
          '1 copy of ' + movieTitle +
          '(' + movieYear + ').'
        );
        $modalAddMovie.modal('show');
      })
      .fail(function (err) {
        $that
          .prop('disabled', false)
          .html('Add failed. Retry?');
      });
  });

});
