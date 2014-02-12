function updateNotes(newNotes) {
  var bedId = $('#bed-id').html().replace(/\s+/g, "");
  var url = '/api/v1/beds/' + bedId;
  $.ajax({
    url: 'api/v1/beds/' + bedId,
    method: 'PATCH',
    dataType: 'json',
    data: {bed: {notes: newNotes}},
    success: function(response) {
    },
    error: function(response) {
    }
  });
}

function showPlantingDetails(element) {
  var planting = $(element).attr('id');
  var plantingCoords = parseId(planting);
  var x = plantingCoords[0];
  var y = plantingCoords[1];
  var bedId = $('#bed-id').html().replace(/\s+/g, "");
  $.ajax({
    url: 'api/v1/plantings/by_coordinates/',
    method: 'GET',
    dataType: 'json',
    data: {planting: {x_coord: x, y_coord: y, bed_id: bedId}},
    success: function(response) {
      var el = $('#planting-details');
      var slug = response['slug'];
      var content = "<p>Planting date: " + response['planting_date'] + "</p>" +
        $("#" + slug).html() + "<br />";
      el.html(content);
    },
    error: function(response) {
      console.log('Error loading planting info');
    }
  });
}

function deletePlanting() {
  confirm("Are you sure?");
  var planting = $('.square-foot.active.planted').attr('id');
  var plantingCoords = parseId(planting);
  var x = plantingCoords[0];
  var y = plantingCoords[1];
  var bedId = $('#bed-id').html().replace(/\s+/g, "");

  $.ajax({
    url: 'api/v1/plantings/',
    method: 'DELETE',
    dataType: 'json',
    data: {planting: {x_coord: x, y_coord: y, bed_id: bedId}},
    success: function(response) {
      var element = $('.square-foot.active.planted');
      element.attr('class', 'square-foot empty');
      element.children('span').html('');
      showBedInfoPanel();
    },
    error: function(response) {
      console.log('Error loading planting info');
    }
  });
}


function addToGarden() {
  var theseSquares, thisSquareId, i, x, y, plant, bed_id, queryData;
  theseSquares = $('.square-foot.active');

  if (checkPlanted(theseSquares)) { return; }

  for (i = theseSquares.length - 1; i >= 0; i--) {
    var thisSquare = theseSquares[i];

    thisSquareId = $(thisSquare).attr('id');
    x = parseId(thisSquareId)[0];
    y = parseId(thisSquareId)[1];
    plant = $('#planting_plants').val();
    bed_id = $('#bed-id').html().replace(/(\s+$|^\s+)/, "");

    queryData = {
      planting: {
        x_coord: x,
        y_coord: y,
        plant_id: plant,
        bed_id: bed_id,
      }
    };

    $.ajax({
      url: '/api/v1/plantings',
      type: 'POST',
      dataType: 'json',
      data: queryData,
      success: function(response) {
        var slug = response["slug"];
        $('.square-foot.active.empty span').html('<img src="' + hostName + '/dashboard/assets/goodveg/' + slug + '.jpg">');
        $('.square-foot.active').removeClass('active').removeClass('empty').addClass('planted');
        showBedInfoPanel();
      },
      error: function(response) {
      }
    });
  }
}