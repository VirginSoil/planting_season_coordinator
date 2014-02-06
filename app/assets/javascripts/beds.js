$(function(){
  $('#actions').click(function(){
    $('.plant-actions').css("display", "inline");
    $('.bed-information').css("display", "none");
    $('.new-plant').css("display", "none");
    $('li#actions a').css("background-color", "green");
    $('li#info a').css("background-color", "#bbb");
    $('li#new-plant a').css("background-color", "#bbb");
  });
  $('#info').click(function(){
    $('.plant-actions').css("display", "none");
    $('.bed-information').css("display", "inline");
    $('li#info a').css("background-color", "green");
    $('li#actions a').css("background-color", "#bbb");
    $('li#new-plant a').css("background-color", "#bbb");
    $('.new-plant').css("display", "none");
  });
  $('#new-plant').click(function(){
    $('.plant-actions').css("display", "none");
    $('.bed-information').css("display", "none");
    $('.new-plant').css("display", "inline");
    $('li#new-plant a').css("background-color", "green");
    $('li#info a').css("background-color", "#bbb");
    $('li#actions a').css("background-color", "#bbb");
  });

  $('td').click(function(e){
    var element = $(e.currentTarget);
    if ($(this).attr("class") == 'square-foot active') {
      element.attr('class', 'square-foot');
      element.css('background-color', 'green');
    } else {
      element.attr('class', 'square-foot active');
      element.css('background-color', 'white');
    }
  });
});
