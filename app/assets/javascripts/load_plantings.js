$(function(){

  var spots = $("#taken-spots").html();
  var takenSpots = JSON.parse(spots);
  loadThePlantings();

  function loadThePlantings() {
    if (takenSpots.length > 0) {
      var allTheSquares = $('.square-foot');
      for (var i = 0; i < allTheSquares.length; i++) {
        var thisOne = parseId($(allTheSquares[i]).attr('id'));
        for (var j = 0; j < takenSpots.length; j++) {
          var takenCoords = [takenSpots[j][0], takenSpots[j][1]];
          var slug = takenSpots[j][2];
          if (arraysIdentical(takenCoords, thisOne)) {
            $(allTheSquares[i]).attr("class", 'square-foot planted');
            var span = $(allTheSquares[i]).children('span');
            $(span).append('<img src="http://localhost:8080/dashboard/assets/goodveg/' + slug + '.jpg">');
          }
        }
      }
    };
  }
});