$(document).ready(function(){
  
  $(function() {
    var start = $("#post_s_time").find(":selected").text().substr(0,2);
    if($("#post_s_meridiem").find(":selected").text() == "pm") {
      start = (parseInt(start) + 12).toString();
    }
    var end = $("#post_e_time").find(":selected").text().substr(0,2);
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
  

  function get_times(beg, end) {
    var times = [beg, end];

    $.each(times, function(index, time) {
      if (time.trim().length) {
        if (time.match(/(A|P)/g)[0] == "P") {
          times[index] = (parseInt(time.substr(0,2))+12)%24;
        } else {
          times[index] = parseInt(time.substr(0,2));
        }
      } else {
        times = [];
      }
    });

    return times;
  }
  

  function add_del_course($data, add) {
    var sel_time = get_times($data.find(".beg_time").text(), $data.find(".end_time").text());
    var sel_days = $data.find(".days").text().split(" ").filter(function(v){return v!==''});
    var crn_id = $data.find(".crn").text();

    $.each(sel_days, function(index, day) {
      var $cell = $("."+sel_time[0]).find("."+day);
      if (add) {
        if (!$cell.find("."+crn_id).length) {
          $cell.append( "<div class=\""+crn_id+"\">"+$data.find("td.title").text()+"</div>" );
        }
      } else {
        $cell.find("."+crn_id).remove();
      }
    });
  }


  /* On mouseup, uses ui-selecting to set selected state and move data
   * to the schedule. For now, relies on adding and removing the
   * "selection" class for multi unselect. */
  $(".selectable td").mouseup(function() {
    var $selected = $(".ui-selecting");

    /* On mouseup, an element will not have ui-selecting class if one
    element is chosen */
    if($selected.length < 1) {
        $selected = $(this).parent();
    }

    $.each($selected, function(index, tr) {
      var $tr = $(tr);
      
      /* check is class is online */
      if (get_times($tr.find(".beg_time").text(), $tr.find(".end_time").text()).length) {
        if($tr.hasClass("selection")) {
          add_del_course($tr, false);
          $tr.removeClass("selection ui-selecting");
        } else {
          add_del_course($tr, true);
          $tr.addClass("selection");
        }
      } else {
        $tr.removeClass( "ui-selecting" );
      }
    });
  });

  /* Adds user selected classes to post TODO: add the data to the post array instead*/
  $( "form" ).submit(function( event ) {
    var selected = $(".ui-selected");
    var text = new Array();
    
    $.each(selected, function (index, elm) {
      var $elm = $(elm);
      text.push($elm.attr("id"));
    });

    $(this).append('<input type="hidden" name="selected_classes" value="'+text.join(" ")+'" />');
  });


  $(function() {
    $("#course_menu").show();
  });

})
