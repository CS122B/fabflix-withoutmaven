$(document).ready(function () {

  var $modalAddMovie = $('#modal-add-movie');
  var $buttonAddMovie = $('#button-add-movie');
  var movieQuantity = $('#movie-quantity').val();

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
