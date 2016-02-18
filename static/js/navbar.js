$(document).ready(function () {

  var ROOT_PATH = '/fabflix';

  var $searchInput = $('#navbar-search-input');
  var $searchResults = $('#navbar-search-results');
  var $searchContainer = $('#navbar-search-results-container');
  var searchInputPosition = $searchInput.offset();

  $searchInput.on('input', function (/* e */) {
    var $that = $(this);
    var currentInput = $that.val();

    if (!currentInput) {
      clearSearchResults();
    } else if (currentInput !== $that.data('lastval')) {
      getSearchResults(currentInput);
    }

    $that.data('lastval', currentInput);
  });

  function getSearchResults(query) {
    var apiRoute =
      ROOT_PATH + '/servlet/autocompleteSearch/' +
      encodeURI(query);

    $.get(apiRoute)
      .done(showSearchResults)
      .fail(clearSearchResults);
  }

  function clearSearchResults(err) {
    if (err) {
      console.log(err);
    }

    $searchContainer.hide();
  }

  function showSearchResults(data) {
    var parsed = JSON.parse(data);
    var resultsHTML;

    if (parsed.suggestions.length) {
      resultsHTML = parsed.suggestions.reduce(function (prev, curr) {
        return prev + (
          '<li class="navbar-suggestion">' +
          '  <a href="' + ROOT_PATH + '/movies/' + curr.id + '">' +
          '    <img ' +
          '      src="' + curr.banner + '" ' +
          '      onerror="this.onerror=null; this.src=\'' + ROOT_PATH + '/static/images/default_poster.jpg\'"' +
          '    />' +
          '    <span>' + curr.title + '</span>' +
          '    <span>(' + curr.year + ')</span>' +
          '  </a>' +
          '</li>'
        );
      }, '');
    } else {
      resultsHTML = '<h5>No results found.</h5>'
    }

    $searchResults.html(resultsHTML);
    $searchContainer
      .css({
        top: searchInputPosition.top + $searchInput.parent().height(),
        left: searchInputPosition.left
      })
      .show();
  }

});
