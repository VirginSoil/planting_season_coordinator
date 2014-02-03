$(document).ready(function() {
  var menuLeft = $( '#cbp-spmenu-s1' ),
      showLeftPush = $( '#showLeftPush' ),
      body = document.body;

  $(showLeftPush).on('click', function(e) {
    e.preventDefault();
    $(this).toggleClass('active');
    $(menuLeft).toggleClass('cbp-spmenu-open');
    $(body).toggleClass('cbp-spmenu-push-toright');
    //disableOther( 'showLeft' );
  });
});
