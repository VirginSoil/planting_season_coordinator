$(function() {
  // resize cells
  var cellWidth =$("#bed-grid-panel td").width();
  $("#bed-grid-panel td").height(cellWidth);
  $(window).resize(function() {
    var cellWidth =$("#bed-grid-panel td").width();
    $("#bed-grid-panel td").height(cellWidth);
  });
});
