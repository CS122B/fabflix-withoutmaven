$(document).ready(function () {

  var ROOT_PATH = '/fabflix';
  var HOVER_INTERVAL = 2000;

  var $form = $('.form-horizontal .form-control');
  var $inputs = $form.filter('input');
  var $selects = $form.filter('select');

  var $modalAddMovie = $('#modal-add-movie');
  var $modalMovieMessage = $('#modal-movie-message');

  var $movieTitleLinks = $('.movie-title-link');

  var $movieHoverCard = $('#movie-hover-card');
  var $movieHoverImage = $('#movie-hover-image');
  var $movieHoverTitle = $('#movie-hover-title');
  var $movieHoverYear = $('#movie-hover-year');
  var $movieHoverId = $('#movie-hover-id');
  var $movieHoverActors = $('#movie-hover-actors');
  var $movieHoverTrailer = $('#movie-hover-trailer');

  var hoverInterval;
  var $currentLinkHover;

  function checkMovieHover() {
    if ($currentLinkHover) {
      var isHoveringOnCurrentLink = $currentLinkHover.is(':hover');
      var isHoveringOnCard = $movieHoverCard.is(':hover');

      if (!(isHoveringOnCurrentLink || isHoveringOnCard)) {
        clearHoverInterval();
      }
    }
  }

  function clearHoverInterval() {
      $currentLinkHover = null;
      clearInterval(hoverInterval);
      $movieHoverCard.hide();
  }

  $('#search-reset').click(function () {
    $inputs.val('');
    $selects.val('none');
  });

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
    // clear previous interval if any
    clearHoverInterval();

    $currentLinkHover = $(this);
    var linkPosition = $currentLinkHover.offset();
    var hoverApiRoute = ROOT_PATH + '/servlet/movieHover/' + $currentLinkHover.attr('data-movie-id');

    $.get(hoverApiRoute)
      .done(function (data) {
        var dataParsed = JSON.parse(data);
        var actors = dataParsed.actors.reduce(function (prev, curr, index) {
          return prev + (
            '<a href="' + ROOT_PATH + '/stars/' + curr.id +
            '">' + curr.first_name + ' ' + curr.last_name + '</a>' +
            (index === dataParsed.actors.length-1 ? '' : ', ')
          );
        }, '');

        hoverInterval = setInterval(checkMovieHover, HOVER_INTERVAL);

        $movieHoverTitle.text(dataParsed.title);
        $movieHoverYear.text(dataParsed.year);
        $movieHoverId.text(dataParsed.id);
        $movieHoverActors.html(actors);
        $movieHoverTrailer.attr('href', dataParsed.trailer_url);
        $movieHoverImage
          .attr('src', dataParsed.banner_url)
          .error(function () {
            $('#movie-hover-image').attr('src', ROOT_PATH + '/static/images/default_poster.jpg')
          });
        $movieHoverCard
          .css({
            top: linkPosition.top + $currentLinkHover.height(),
            left: linkPosition.left
          })
          .show();
      })
      .fail(function (err) {
        console.log(err);
      });
  });

});
