$(document).ready(function () {

  var $modalAddMovie = $('#modal-add-movie');
  var $modalMovieBody = $('#modal-movie-body');
  var $buttonAddMovie = $('#button-add-movie');
  var $selectMovieQuantity = $('#movie-quantity');
  var $movieTitle = $('#movie-title');
  var $movieYear = $('#movie-year');
  var $movieImage = $('#movie-image');
  var movieQuantity = $selectMovieQuantity.val();
  var copyNum;

  $selectMovieQuantity.change(function (/* e */) {
    movieQuantity = $selectMovieQuantity.val();
  });

  $buttonAddMovie.click(function (/* e */) {
    $buttonAddMovie
      .prop('disabled', true)
      .html('Add to Cart');

    var postData = {
      movieId: $buttonAddMovie.attr('data-movie-id'),
      quantity: movieQuantity
    };

    $.post('/TomcatForm/servlet/user/addToCart', postData)
      .done(function (data) {
        copyNum = (+movieQuantity > 1) ? ' copies of ' : ' copy of ';
        $modalMovieBody.html('You have added ' + movieQuantity + copyNum + $movieTitle.html() + ' (' + $movieYear.html() + ').');
        $modalAddMovie.modal('show');
      })
      .fail(function (err) {
        $buttonAddMovie
          .prop('disabled', false)
          .html('Add failed. Retry?');
      });
  });

});
