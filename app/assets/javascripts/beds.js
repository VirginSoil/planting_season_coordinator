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
    // return id.split("-").slice(1,3).map(function(e) {return parseInt(e);});
  };

  function arraysIdentical(a, b) {
    var i = a.length;
    if (i != b.length) return false;
    while (i--) {
        if (a[i] !== b[i]) return false;
    }
    return true;
  };

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
  };

  function selectPlanted(element) {
    element.attr('class', 'square-foot active planted');
    element.css('background-color', 'green');
    showPlantActionsPanel();
  };

  function deselectPlanted(element) {
    element.attr('class', 'square-foot planted');
    element.css('background-color', 'white');
    showBedInfoPanel();
  };

  function selectUnplanted(element) {
    element.attr('class', 'square-foot active');
    element.css('background-color', 'green');
    showNewPlantPanel();
  };

  function deselectUnplanted(element) {
    element.attr('class', 'square-foot');
    element.css('background-color', 'white');
    showBedInfoPanel();
  }


});
