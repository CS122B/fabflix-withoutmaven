$(document).ready(function () {

  var ROOT_PATH = '/fabflix';
  var $form = $('.form-horizontal .form-control');
  var $inputs = $form.filter('input');
  var $selects = $form.filter('select');
  $('#search-reset').click(function () {
    $inputs.val('');
    $selects.val('none');
  });

  var $modalAddMovie = $('#modal-add-movie');
  var $modalMovieMessage = $('#modal-movie-message');

  var $movieTitleLinks = $('.movie-title-link');

  var $movieHoverImage = $('#movie-hover-image');
  var $movieHoverTitle = $('#movie-hover-title');
  var $movieHoverYear = $('#movie-hover-year');
  var $movieHoverId = $('#movie-hover-id');
  var $movieHoverActors = $('#movie-hover-actors');
  var $movieHoverTrailer = $('#movie-hover-trailer');

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

    $.post(ROOT_PATH + '/servlet/user/addToCart', postData)
      .done(function (data) {
        $modalMovieMessage.html(
          '1 copy of ' + movieTitle +
          ' (' + movieYear + ').'
        );
        $modalAddMovie.modal('show');
      })
      .fail(function (err) {
        $that
          .prop('disabled', false)
          .html('Add failed. Retry?');
      });
  });

  $movieTitleLinks.mouseenter(function (e) {
    $.get(ROOT_PATH + '/servlet/movieHover/' + $(this).attr('data-movie-id'))
      .done(function (data) {
        var dataParsed = JSON.parse(data);
        var actors = dataParsed.actors.reduce(function (prev, curr, index) {
          var actorLink = '<a href="' + ROOT_PATH + '/stars/' +
            curr.id + '">' + curr.first_name + ' ' + curr.last_name + '</a>' +
            (index === dataParsed.actors.length-1 ? '' : ', ');

          return prev + actorLink;
        }, '');

        $movieHoverImage
          .attr('src', dataParsed.banner_url)
          .error(function () {
            $('#movie-hover-image').attr('src', ROOT_PATH + '/static/images/default_poster.jpg')
          });
        $movieHoverTitle.text(dataParsed.title);
        $movieHoverYear.text(dataParsed.year);
        $movieHoverId.text(dataParsed.id);
        $movieHoverActors.html(actors);
        $movieHoverTrailer.attr('href', dataParsed.trailer_url);
      })
      .fail(function (err) {
        console.log(err);
      })
  });

});
