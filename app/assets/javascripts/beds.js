$(function(){
  window.isMouseDown = false;
  var spots = $("#taken-spots").html();
  var takenSpots = JSON.parse(spots);

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

  function parseId(id) {
    return id.split("-").slice(1,3);
  };

  function arraysIdentical(a, b) {
    var i = a.length;
    if (i != b.length) return false;
    while (i--) {
        if (a[i] !== b[i]) return false;
    }
    return true;
  };

  $('#edit-notes-button').click(function(e){
    e.preventDefault();
    var notes = $("#loaded-notes").html().replace(/(\s+$|^\s+)/, "");
    $("#loaded-notes").html("");
    $('#save-notes-button').css("display", "inline");
    $('#bed-notes-form').css("display", "inline");
    $('#bed-notes-form').val(notes);
    $('#edit-notes-button').css("display", "none");
  });

  $('#save-notes-button').click(function(e){
    e.preventDefault();
    var newNotes = $("#bed-notes-form").val();
    $("#loaded-notes").html(newNotes);
    $('#save-notes-button').css("display", "none");
    $('#bed-notes-form').css("display", "none");
    $('#bed-notes-form').val("");
    $('#edit-notes-button').css("display", "inline");
    updateNotes(newNotes);
  });

  $('#delete-planting-button').click(function(e){
    e.preventDefault();
    deletePlanting();
  });

  $('#actions').click(function(){
    showPlantActionsPanel();
  });

  $('#info').click(function(){
    showBedInfoPanel();
  });

  $('#new-plant').click(function(){
    showNewPlantPanel();
  });

  $('select').change(function() {
    var plant = $(this).val();
    showPlantInfo(plant);
  });

  $('td').mousedown(function(e){
    window.isMouseDown = true;
    var element = $(e.currentTarget);
    var thisClass = $(this).attr("class");
    toggleSquare(thisClass, element);
    return false;
  });

   $('td').mouseenter(function(e){
    if (window.isMouseDown){
      var element = $(e.currentTarget);
      var thisClass = $(this).attr("class");
      toggleSquare(thisClass, element);
    }
    return false;
  });

  $(document)
    .mouseup(function () {
    window.isMouseDown = false;
  });

  function toggleSquare(thisClass, element) {
    if ( thisClass == 'square-foot planted') {
      selectPlanted(element);
      showPlantingDetails(element);
    } else if (thisClass == 'square-foot active planted') {
      deselectPlanted(element);
    } else if (thisClass == 'square-foot active empty') {
      deselectUnplanted(element);
    } else {
      selectUnplanted(element);
    }
  }

  function showBedInfoPanel() {
    $('.bed-information').css("display", "inline");
    $('.plant-actions').css("display", "none");
    $('.new-plant').css("display", "none");
    $('.action.active').removeClass('active');
    $('#info').addClass("active");
  }

  function showPlantActionsPanel() {
    $('.plant-actions').css("display", "inline");
    $('.bed-information').css("display", "none");
    $('.new-plant').css("display", "none");
    $('.action.active').removeClass('active');
    $('#actions').addClass("active");
  }

  function showNewPlantPanel() {
    $('.new-plant').css("display", "inline");
    $('.plant-actions').css("display", "none");
    $('.bed-information').css("display", "none");
    $('.action.active').removeClass('active');
    $('#new-plant').addClass("active");
  }

  function selectPlanted(element) {
    element.attr('class', 'square-foot active planted');
    showPlantActionsPanel();
    showPlantingDetails(element);
  }

  function deselectPlanted(element) {
    element.attr('class', 'square-foot planted');
    showBedInfoPanel();
  }

  function selectUnplanted(element) {
    element.attr('class', 'square-foot active empty');
    showNewPlantPanel();
  }

  function deselectUnplanted(element) {
    element.attr('class', 'square-foot empty');
    showBedInfoPanel();
  }

  function updateNotes(newNotes) {
    var bedId = $('#bed-id').html().replace(/\s+/g, "");
    var url = 'http://localhost:8080/api/v1/beds/' + bedId;
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
        alert('There was a slight problem, Bobberino!');
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
        alert('There was a slight problem, Bobberino!');
      }
    });
  }

  $('#add-to-garden').on("click", function(e) {
    var theseSquares, thisSquareId, x, y, plant, bed_id, queryData;

    e.preventDefault();
    theseSquares = $('.square-foot.active');
    if (theseSquares.length === 0) {
      alert("Please select a square!");
      return;
    }

    for (var i = theseSquares.length - 1; i >= 0; i--) {
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
          $('.square-foot.active.empty span').html('<img src="http://localhost:8080/dashboard/assets/goodveg/' + slug + '.jpg">');
          $('.square-foot.active').removeClass('active').removeClass('empty').addClass('planted');
          showBedInfoPanel();
        },
        error: function(response) {
        }
      });
    };
  });

  function showPlantInfo(plantName) {
    var slug = URLify(plantName);
    var plantInfo = $("#" + slug);
    $('#plant-info').html(plantInfo);
  }

  function parseId(id) {
    return id.split("-").slice(1,3);
  }


});
