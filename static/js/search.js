$(document).ready(function () {

  // var $form = $('.form-horizontal .form-control');
  // var $inputs = $form.filter('input');
  // var $selects = $form.filter('select');
  // $('#search-reset').click(function () {
  //   $inputs.val('');
  //   $selects.val('none');
  // });

  // var $modalAddMovie = $('#modal-add-movie');
  // var $modalQuantityAdded = $('#modal-quantity-added');
  // var $buttonAddMovie = $('#button-add-movie');

  // $buttonAddMovie.click(function (/* e */) {
  //   $buttonAddMovie
  //     .prop('disabled', true)
  //     .html('Add to Cart');

  //   var movieId = $buttonAddMovie
  //     .attr('data-movie-id')
  //     .replace(/\s/g, '');

  //   var postData = {
  //     movieId: movieId,
  //     quantity: 1
  //   };

  //   $.post('/TomcatForm/servlet/user/addToCart', postData)
  //     .done(function (data) {
  //       var copyNum = (+movieQuantity > 1) ? ' copies ' : ' copy ';
  //       $modalQuantityAdded.html(movieQuantity + copyNum);
  //       $modalAddMovie.modal('show');
  //     })
  //     .fail(function (err) {
  //       $buttonAddMovie
  //         .prop('disabled', false)
  //         .html('Add failed. Retry?');
  //     });
  // });

});
