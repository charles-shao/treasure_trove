$(document).ready(function(){

  if ($("#treasureCarousel")) {
    $("#treasureCarousel").carousel();
    $("#treasureCarousel").carousel('pause');
  }

  $("#search").on('click', function(){
    search($("#search_param").val());
    $("#treasureCarousel").carousel('next');
  });

  $(document).on('click', '.active-result', function(){
    var _has_next = $("#treasureCarousel > .carousel-inner > .item.active").next().length;
    var record = $(this).attr('article');
    if (_has_next) {
      $("#treasureCarousel > .carousel-inner > .item.active").next().delete();
    }
    getRecord(record);
    setTimeout(function(){}, 2000);
    $("#treasureCarousel").carousel('next');
  });

  function getRecord(record) {
    $.ajax({
      url: '/details/get_record',
      type: 'get',
      async: false,
      dataType: 'text',
      data: {q_article: record},
      success: function(data) {
        $("#treasureCarousel > .carousel-inner").append(data);
      },
      error: function(request, error){
        console.log("Something went wrong");
        alert(request + ":" + error);
      }
    });
  }

  function search(search_parameter){
    $.ajax({
      url: '/results/fetch_result',
      type: 'post',
      async: false,
      dataType: 'text',
      data: {q: search_parameter},
      success: function(data){
        $("#treasureCarousel > .carousel-inner").append(data);
      },
      error: function(request, error){
        console.log("Something went wrong");
        alert(request + ":" + error);
      }
    });
  }



});