$(function() {
  $('#add-to-garden').on("click", function(e) {
    var x_coordinate, y_coordinate, plant, bed_id, queryData;

    e.preventDefault();
    x = $('#planting_row').val();
    y = $('#planting_column').val();
    plant = $('#planting_plants').val();
    bed_id = 1;
    queryData = {planting: { row: x, column: y, plant_id: plant, bed_id: bed_id}};

    $.ajax({
      url: 'http://localhost:9293/api/v1/plantings',
      type: 'POST',
      dataType: 'json',
      data: queryData,
      success: function(response) {
        alert('success!');
        debugger;
      },
      error: function(response) {
        debugger;
        alert('failure!');
      }
    });
  });
});