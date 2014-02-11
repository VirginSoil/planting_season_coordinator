$(function() {
  // resize cells
  var cellWidth =$("#bed-grid-panel td").width();
  $("#bed-grid-panel td").height(cellWidth);
  $("#bed-grid-panel td span").height(cellWidth);
  $("#bed-grid-panel td img").height(cellWidth);
  $(window).resize(function() {
    var cellWidth =$("#bed-grid-panel td").width();
    $("#bed-grid-panel td").height(cellWidth);
    $("#bed-grid-panel td span").height(cellWidth + 1);
    $("#bed-grid-panel td img").height(cellWidth + 1);
  });
});
