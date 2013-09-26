$(document).ready(function(){
  $(':radio').change(function() {
    changeCheck(this);
  });

  function changeCheck(x) {
    var option = $(x).attr('id');
    switch(option) {
      case 'course_title':
        if ($('.course_title').is(':hidden')) {
          $('.course_title').fadeIn();
        }
        $('.slash').fadeOut();
        $('.course_num').fadeOut();
        break;
      case 'course_num':
        if ($('.course_num').is(':hidden')) {
          $('.course_num').fadeIn();
        }
        $('.slash').fadeOut();
        $('.course_title').fadeOut();
        break;
      default:
        $('.course_title').fadeIn();
        $('.slash').fadeIn();
        $('.course_num').fadeIn();
        break;  
    }
  }

  $(function() {
    $("#selectable").bind("mousedown", function(e) {
        e.metaKey = true;
    }).selectable({
      filter: $('#selectable').children('li')
    });
  });
});