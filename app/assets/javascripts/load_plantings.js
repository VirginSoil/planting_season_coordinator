$(function(){

  var spots = $("#taken-spots").html();
  var takenSpots = JSON.parse(spots);
  loadThePlantings();

  function loadThePlantings() {
    if (takenSpots.length < 1) { return; }
    var allTheSquares = $('.square-foot');
    for (var i = 0; i < allTheSquares.length; i++) {
      var thisOne = parseId($(allTheSquares[i]).attr('id'));
      for (var j = 0; j < takenSpots.length; j++) {
        var takenCoords = [takenSpots[j][0], takenSpots[j][1]];
        var slug = takenSpots[j][2];
        if (arraysIdentical(takenCoords, thisOne)) {
          $(allTheSquares[i]).attr("class", 'square-foot planted');
          var span = $(allTheSquares[i]).children('span');
          if (takenSpots[j][3] === false) {
            $(span).append('<img src="' + hostName + '/dashboard/assets/goodveg/' + slug + '.jpg">');
          } else {
            $(span).append('<img src="' + hostName + '/dashboard/assets/goodveg/' + slug + '-harvested.jpg">');
          }
        }
      }
    }
  }
});