$(function() {

  // resize cells
  var cellWidth =$("#bed-grid-panel td").width();
  $("#bed-grid-panel td").height(cellWidth);
  $(window).resize(function() {
    var cellWidth =$("#bed-grid-panel td").width();
    $("#bed-grid-panel td").height(cellWidth);
  });

  $('#add-to-garden').on("click", function(e) {
    var thisSquare, thisSquareId, x, y, plant, bed_id, queryData;

    e.preventDefault();
    thisSquare = $('.square-foot.active')[0];
    if (thisSquare === undefined) {alert("Please select a square!")}
    thisSquareId = $(thisSquare).attr('id');
    x = parseId(thisSquareId)[0];
    y = parseId(thisSquareId)[1];
    plant = $('#planting_plants').val();
    bed_id = 1;

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
        alert('success!');
        debugger;
      },
      error: function(response) {
        alert('failure!');
        debugger;
      }
    });
  });

  $('select').change(function() {
    var plant = $(this).val();
    showPlantInfo(plant);
  });

  function showPlantInfo(plantName) {
    var slug = URLify(plantName);
    var plantInfo = $("#" + slug);
    $('#plant-info').html(plantInfo);
    debugger;
  }

  function parseId(id) {
    return id.split("-").slice(1,3);
    // return id.split("-").slice(1,3).map(function(e) {return parseInt(e);});
  }
});
