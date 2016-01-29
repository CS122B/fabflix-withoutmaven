$(document).ready(function () {

  var $modalAddMovie = $('#modal-add-movie');
  var $modalQuantityAdded = $('#modal-quantity-added');
  var $buttonAddMovie = $('#button-add-movie');
  var $selectMovieQuantity = $('#movie-quantity');
  var $movieTitle = $('#movie-title');
  var $movieYear = $('#movie-year');
  var $movieImage = $('#movie-image');
  var movieQuantity = $selectMovieQuantity.val();
  var copyNum;

  $selectMovieQuantity.change(function (/* e */) {
    movieQuantity = $selectMovieQuantity.val();
    $buttonAddMovie.prop('disabled', false);
  });

  $buttonAddMovie.click(function (/* e */) {
    $buttonAddMovie
      .prop('disabled', true)
      .html('Add to Cart');

    var movieId = $buttonAddMovie
      .attr('data-movie-id')
      .replace(/\s/g, '');

    var postData = {
      movieId: movieId,
      quantity: movieQuantity
    };

    $.post('/TomcatForm/servlet/user/addToCart', postData)
      .done(function (data) {
        copyNum = (+movieQuantity > 1) ? ' copies ' : ' copy ';
        $modalQuantityAdded.html(movieQuantity + copyNum);
        $modalAddMovie.modal('show');
      })
      .fail(function (err) {
        $buttonAddMovie
          .prop('disabled', false)
          .html('Add failed. Retry?');
      });
  });

});
