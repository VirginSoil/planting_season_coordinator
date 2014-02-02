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

  //function disableOther( button ) {
  //  if( button !== 'showLeft' ) {
  //    $(showLeft).toggleClass('disabled');
  //  }
  //  if( button !== 'showRight' ) {
  //    classie.toggle( showRight, 'disabled' );
  //  }
  //  if( button !== 'showTop' ) {
  //    classie.toggle( showTop, 'disabled' );
  //  }
  //  if( button !== 'showBottom' ) {
  //    classie.toggle( showBottom, 'disabled' );
  //  }
  //  if( button !== 'showLeftPush' ) {
  //    classie.toggle( showLeftPush, 'disabled' );
  //  }
  //  if( button !== 'showRightPush' ) {
  //    classie.toggle( showRightPush, 'disabled' );
  //  }
  //}
});
