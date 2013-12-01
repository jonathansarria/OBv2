$(document).ready(function(){
  $(function() {
    $("#course_menu").show();
  });

  $(function() {
    $('#course_menu').dataTable({
      //"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
      "sDom": "flrtip",
      //"sPaginationType": "bootstrap",
      "bPaginate": false,
      "bLengthChange": false,
      "bFilter": true,
      "bSort": true,
      "bInfo": false,
      "bAutoWidth": false,
      "sScrollY": 500,
      "sScrollX": 500
    });
  });

  $(function() {
    var start = $("#post_s_time").find(":selected").text().substr(0,2);
    var end = $("#post_e_time").find(":selected").text().substr(0,2);
    
    if($("#post_s_meridiem").find(":selected").text() == "pm") {
      start = (parseInt(start) + 12).toString();
    }
    
    if($("#post_e_meridiem").find(":selected").text() == "pm") {
      end = (parseInt(end) + 12).toString();
    }
  });

  $(function() {
    $("#course_menu").bind("mousedown", function(e) {
      e.metaKey = true;
    }).selectable({
      filter: '.selectable'
    });
  });

  function getTimes(beg, end) {
    var times = [beg, end];

    $.each(times, function(index, time) {
      if (time.trim().length) {
        if (time.match(/(A|P)/g)[0] == "P") {
          times[index] = parseInt(time.substr(0,2))+12;
          if (times[index] == 24) {
            times[index] = times[index] - 12
          }
        } else {
          times[index] = parseInt(time.substr(0,2));
          if (times[index] == 12) {
            times[index] = times[index] - 12
          }
        }
      } else {
        times = [];
      }
    });

    return times;
  }

  function addDelCourse($data, add) {
    var selTime = getTimes($data.find(".beg_time").text(), $data.find(".end_time").text());
    var selDays = $data.find(".days").text().split(" ").filter(function(v){return v!==''});
    var crnId = $data.find(".crn").text();
    var $cell = null;
    var $cellChildren = null;

    $.each(selDays, function(index, day) {
      $cell = $("."+selTime[0]).find("."+day);
      
      if (add) {
        if (!$cell.find("."+crnId).length) {
          $cell.append( "<div class=\""+crnId+"\">"+$data.find("td.title").text()+"</div>" );
          $cellChildren = $cell.children();

          if($cellChildren.length == 1) {
            for(i=selTime[0]; i<=selTime[1]; i++) {
              $cell = $("."+i).find("."+day);
              
              $cell.css("background", "green");
            }
          } else {
            for(i=selTime[0]; i<=selTime[1]; i++) {
              $cell = $("."+i).find("."+day);
              
              $cell.css("background", "red");
            }
          }
        }
      } else {
        $cell.find("."+crnId).remove();
        $cellChildren = $cell.children();

        if($cellChildren.length == 0) {
          for(i=selTime[0]; i<=selTime[1]; i++) {
            $cell = $("."+i).find("."+day);
            
            $cell.css("background", "transparent");
          }
        } else if($cellChildren.length == 1) {
          for(i=selTime[0]; i<=selTime[1]; i++) {
            $cell = $("."+i).find("."+day);
            
            $cell.css("background", "green");
          }
        } else {
          for(i=selTime[0]; i<=selTime[1]; i++) {
            $cell = $("."+i).find("."+day);
            
            $cell.css("background", "red");
          }
        }
      }
    });
  }

  /* On mouseup, uses ui-selecting to set selected state and move data
  * to the schedule. For now, relies on adding and removing the
  * "selection" class for multi unselect. */
  function multiSelect(elm) {
    var $selected = $(".ui-selecting");
    var $tr = null;

    /* On mouseup, an element will not have ui-selecting class if one
    element is chosen */
    if($selected.length < 1) {
      $selected = $(elm).parent();
    }

    $.each($selected, function(index, tr) {
      $tr = $(tr);

      /* check is class is online */
      if (getTimes($tr.find(".beg_time").text(), $tr.find(".end_time").text()).length) {
        if($tr.hasClass("selection")) {
          addDelCourse($tr, false);
          $tr.removeClass("selection ui-selecting");
        } else {
          addDelCourse($tr, true);
          $tr.addClass("selection");
        }
      } else {
        $tr.removeClass( "ui-selecting" );
      }
    });
  }

  var isDragging = false;
  var onCourses = false;

  $(".selectable td").mousedown(function() {
    onCourses = true;

    $(window).mousemove(function() {
      isDragging = true;
    $(window).unbind("mousemove");
    });
  })
  .mouseup(function() {
    if(onCourses) {
      multiSelect(this);
    }
    
    isDragging = false;
    $(window).unbind("mousemove");

    onCourses = false;
  });

  $(this).mouseup(function(e) {
    var $tr = $(e.target).parent();
    
    if(!$tr.hasClass("selectable")){
      var $unHighlight = $(".ui-selecting");
      var $elm=null;

      $.each($unHighlight, function(index, elm) {
        $elm = $(elm);
        $elm.removeClass("ui-selecting");
      });
    }
  });

  /* Adds user selected classes to post TODO: add the data to the post array instead*/
  $( "form" ).submit(function( event ) {
    var selected = $(".ui-selected");
    var text = new Array(); //has to be submitted as array!
    var $elm = null;

    $.each(selected, function (index, elm) {
      $elm = $(elm);
      
      text.push($elm.attr("id"));
    });

    $(this).append('<input id="post_courses" type="hidden" name="post[courses][]" value="['+text.join()+']" />');
  });
});
