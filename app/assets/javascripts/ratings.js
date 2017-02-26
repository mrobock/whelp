$(document).ready(function() {

//Hover Functionality
  //1 Star
  $("#star_1").hover(function() {
    onHover(1);
  }, function() {
    offHover();
  });
  //2 Star
  $("#star_2").hover(function() {
    onHover(2);
  }, function() {
    offHover();
  });
  //3 Star
  $("#star_3").hover(function() {
    onHover(3);
  }, function() {
    offHover();
  });
  //4 Star
  $("#star_4").hover(function() {
    onHover(4);
  }, function() {
    offHover();
  });
  //5 Star
  $("#star_5").hover(function() {
    onHover(5);
  }, function() {
    offHover();
  });



  //Star Hover
  function onHover(id) {
    //Add Stars
      for(var i = 1; i <= id; i++) {
        $("#star_" + i).attr("src", "star-off.png").attr("src", "/assets/star-on.png");
      };
  }
  //Remove stars on off hover
  function offHover() {
    for(var i = 1; i <=5; i++) {
      $("#star_" + i).attr("src", "star-on.png").attr("src", "/assets/star-off.png");
    }
  }

//Reset once off SPAN!!!!!
  $("#rating_span").hover(function(){},function(){
    getRating();
  });

//Submit rating functionality
  //Star 1
  $("#star_1").click(function(event){
    ajaxRating(1);
    event.stopPropagation();
  });
  //Star 2
  $("#star_2").click(function(event){
    ajaxRating(2);
    event.stopPropagation();

  });
  //Star 3
  $("#star_3").click(function(event){
    ajaxRating(3);
    event.stopPropagation();

  });
  //Star 4
  $("#star_4").click(function(event){
    ajaxRating(4);
    event.stopPropagation();

  });
  // Star 5
  $("#star_5").click(function(event){
    ajaxRating(5);
    event.stopPropagation();
  });

  //Turns stars on if rating already exists and sets Avg Rating and Total Ratings
  getRating();
  updateAvgCnt();

  function getRating() {
  //Check to see if on Event Page or Venue Page. If Venue, rating_venue_id will be defined, and vice-versa.
    if($("#rating_venue_id").val() === undefined) {
      var type = "event"
    } else {
      var type = "venue"
    };
    $.get("/ratings/" + $("#rating_user_id").val() + "/get_rating?type_id=" + $("#rating_"+type+"_id").val() + "&type=" + type).success(function(data) {
      for (var i = 1; i <= 5; i++) {
        $("#star_" + i).attr("src", "star-on.png").attr("src", "/assets/star-off.png");
      }
      for (var i = 1; i <= data.rating; i++) {
        $("#star_" + i).attr("src", "star-off.png").attr("src", "/assets/star-on.png");
      };
    });
  };

//Submitting ratings!
  function ajaxRating(rate_value) {
    //If the hidden rating field equals 0 (i.e. user hasn't rated yet) then we POST a new rating
    if($("#rating_venue_id").val() === undefined) {
      var type = "event"
    } else {
      var type = "venue"
    };
    $.get("/ratings/" + $("#rating_user_id").val() + "/get_rating?type_id=" + $("#rating_"+type+"_id").val() + "&type=" + type).success(function(data) {
      if (data.rating == 0) {
        var ajax_method = 'POST';
        var ajax_url = "/ratings/";
      } else { //If the hidden rating field is not 0 (i.e. user has a rating already that is succesfully passed through) the we PUT (i.e. update) the new rating
        var ajax_method = 'PUT';
        var ajax_url = "/ratings/" + data.id;
      };
      buildRating(rate_value, ajax_method, ajax_url);
    });
  }
// Builds new rating JSON and then AJAX's it
  function buildRating(rate_value, ajax_method, ajax_url) {
    var newRating = {
     "rating": {
       "rating": rate_value,
       "user_id": $("#rating_user_id").val(),
       "venue_id": $("#rating_venue_id").val(),
       "event_id": $("#rating_event_id").val()
      }
    }
  //AJAX starts here
    $.ajax({
      dataType: 'json',
      url: ajax_url,
      method: ajax_method,
      data: newRating,
      success: function(data) {
        getRating();
      //Reset rating ID (imp't for first rating, otherwise rating ID is always set at 0 and User can rate infinite times and stars will not set correctly)
        $("#rating_rating_id").val(data.id);
        updateAvgCnt();
      },
      error: function(jqXHR, testStatus, errorThrown) {
        alert("Unable to add/update rating because " + errorThrown);
      }
    });
  }

  function updateAvgCnt() {
    if($("#rating_venue_id").val() === undefined) {
      var type = "event"
    } else {
      var type = "venue"
    };
    $.ajax({
      dataType: 'json',
      url: "/ratings/" + $("#rating_"+type+"_id").val() + "/rating_update?type=" + type,
      method: 'GET',
      success: function(data) {
        $("#avg_rating").text(data.average);
        $("#count_rating").text(data.count);
      },
      error: function(jqXHR, testStatus, errorThrown) {
        alert("Unable to update average rating because " + errorThrown);
      }
    });
  }
});
