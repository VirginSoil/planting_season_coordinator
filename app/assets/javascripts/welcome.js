$(function() {
  $('#add-to-garden').on("click", function(e) {
    var thisSquare, thisSquareId, x, y, plant, bed_id, queryData;

    e.preventDefault();
    thisSquare = $('.square-foot.active')[0];
    if (thisSquare === undefined) {alert("Please select a square!")}
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
        debugger;
        $('.square-foot.active').attr('class', 'square-foot active planted');
        $('.square-foot.active.planted').html('<img src="http://www.placekitten.com/50/50">');
      },
      error: function(response) {
        alert('There was a slight problem, Bobberino!');
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
  }

  function parseId(id) {
    return id.split("-").slice(1,3);
    // return id.split("-").slice(1,3).map(function(e) {return parseInt(e);});
  }
});
