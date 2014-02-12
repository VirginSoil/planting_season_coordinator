$(function() {
  window.isMouseDown = false;

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

  $(document).mouseup(function () {
    window.isMouseDown = false;
  });

});