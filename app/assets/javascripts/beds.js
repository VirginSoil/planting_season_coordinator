$(function(){
  var spots = $("#taken-spots").html();
  var takenSpots = JSON.parse(spots);

  if (takenSpots.length > 0) {
    var allTheSquares = $('.square-foot');
    for (var i = 0; i < allTheSquares.length; i++) {
      var thisOne = parseId($(allTheSquares[i]).attr('id'));
      for (var j = 0; j < takenSpots.length; j++) {
        if (arraysIdentical(takenSpots[j], thisOne)) {
          $(allTheSquares[i]).attr("class", 'square-foot planted');
          $(allTheSquares[i]).append('<img src="http://www.placekitten.com/50/50">');
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

  $('td').click(function(e){
    var element = $(e.currentTarget);
    var thisClass = $(this).attr("class");
    if ( thisClass == 'square-foot planted') {
      if ($('.active').length > 0) { return; }
      selectPlanted(element);
    } else if (thisClass == 'square-foot active planted') {
      deselectPlanted(element);
    } else if (thisClass == 'square-foot active') {
      deselectUnplanted(element);
    } else {
      if ($('.active').length > 0) { return; }
      selectUnplanted(element);
    }
  });

  function showBedInfoPanel() {
    $('.plant-actions').css("display", "none");
    $('.bed-information').css("display", "inline");
    $('li#info a').css("background-color", "green");
    $('li#actions a').css("background-color", "#bbb");
    $('li#new-plant a').css("background-color", "#bbb");
    $('.new-plant').css("display", "none");
  }

  function showPlantActionsPanel() {
    $('.plant-actions').css("display", "inline");
    $('.bed-information').css("display", "none");
    $('.new-plant').css("display", "none");
    $('li#actions a').css("background-color", "green");
    $('li#info a').css("background-color", "#bbb");
    $('li#new-plant a').css("background-color", "#bbb");
  }

  function showNewPlantPanel() {
    $('.plant-actions').css("display", "none");
    $('.bed-information').css("display", "none");
    $('.new-plant').css("display", "inline");
    $('li#new-plant a').css("background-color", "green");
    $('li#info a').css("background-color", "#bbb");
    $('li#actions a').css("background-color", "#bbb");
  }

  function selectPlanted(element) {
    element.attr('class', 'square-foot active planted');
    element.css('background-color', 'green');
    showPlantActionsPanel();
  }

  function deselectPlanted(element) {
    element.attr('class', 'square-foot planted');
    element.css('background-color', 'white');
    showBedInfoPanel();
  }

  function selectUnplanted(element) {
    element.attr('class', 'square-foot active');
    element.css('background-color', 'green');
    showNewPlantPanel();
  }

  function deselectUnplanted(element) {
    element.attr('class', 'square-foot');
    element.css('background-color', 'white');
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
        var element = $('.square-foot.active.planted')
        element.attr('class', 'square-foot');
        element.css('background-color', 'white');
        element.html('');
        showBedInfoPanel();
      },
      error: function(response) {
        alert('There was a slight problem, Bobberino!');
      }
    });
  }

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
        $('.square-foot.active').attr('class', 'square-foot active planted');
        $('.square-foot.active.planted').html('<img src="http://www.placekitten.com/50/50">');
        showPlantActionsPanel();
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
