$(document).ready(function () {

  var $modalAddMovie = $('#modal-add-movie');
  var $buttonAddMovie = $('#button-add-movie');
  var $selectMovieQuantity = $('#movie-quantity');
  var movieQuantity = $selectMovieQuantity.val();

  $selectMovieQuantity.change(function (/* e */) {
    movieQuantity = $selectMovieQuantity.val();
  });

  $buttonAddMovie.click(function (/* e */) {
    var movieId = $buttonAddMovie.attr('data-movie-id');
    $.post('/TomcatForm/servlet/user/addToCart', {
      movieId: movieId,
      quantity: movieQuantity
    })
    .done(function (data) {
      console.log(data);
      console.log('success');
      $modalAddMovie.modal('show');
    })
    .fail(function (err) {
      console.log(err);
      alert('faillll');
    });
  });

});
