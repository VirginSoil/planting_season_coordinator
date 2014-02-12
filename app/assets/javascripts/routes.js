$(function() {

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

  $('#harvest-button').click(function(e){
    e.preventDefault();
    harvestPlanting();
  });

  $('#delete-planting-button').click(function(e){
    e.preventDefault();
    deletePlanting();
  });

  $('#add-to-garden').click(function(e) {
    e.preventDefault();
    addToGarden();
  });

  $('#edit-notes-button').click(function(e){
    e.preventDefault();
    showEditNotes();
  });

  $('#save-notes-button').click(function(e){
    e.preventDefault();
    showSavedNotes();
  });

});