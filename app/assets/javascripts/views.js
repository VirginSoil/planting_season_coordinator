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

function showEditNotes() {
  var notes = $("#loaded-notes").html().replace(/(\s+$|^\s+)/, "");
  $("#loaded-notes").html("");
  $('#save-notes-button').css("display", "inline");
  $('#bed-notes-form').css("display", "inline");
  $('#bed-notes-form').val(notes);
  $('#edit-notes-button').css("display", "none");
}

function showSavedNotes() {
  var newNotes = $("#bed-notes-form").val();
  $("#loaded-notes").html(newNotes);
  $('#save-notes-button').css("display", "none");
  $('#bed-notes-form').css("display", "none");
  $('#bed-notes-form').val("");
  $('#edit-notes-button').css("display", "inline");
  updateNotes(newNotes);
}

function showPlantInfo(plantName) {
  var slug = URLify(plantName);
  var plantInfo = $("#" + slug);
  $('#plant-info').html(plantInfo);
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
