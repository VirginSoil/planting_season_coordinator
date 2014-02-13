function toggleSquare(thisClass, element) {
  if ( thisClass === 'square-foot planted' || thisClass === 'square-foot planted harvested') {
    selectPlanted(element);
    showPlantingDetails(element);
  } else if (thisClass === 'square-foot planted active' || thisClass == 'square-foot planted harvested active') {
    //alert(thisClass);
    deselectPlanted(element);
  } else if (thisClass === 'square-foot empty active') {
    deselectUnplanted(element);
  } else {
    selectUnplanted(element);
  }
}

function selectPlanted(element) {
  element.addClass('active');
  showPlantActionsPanel();
  showPlantingDetails(element);
}

function deselectPlanted(element) {
  element.removeClass('active');
  showBedInfoPanel();
}

function selectUnplanted(element) {
  element.addClass('active');
  showNewPlantPanel();
}

function deselectUnplanted(element) {
  element.removeClass('active');
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
