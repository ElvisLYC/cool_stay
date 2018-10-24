
$(document).on('turbolinks:load', function(){
  alert("niama")
  $("#listing_term").keyup(function(){
    autocomplete()
  });
})
function autocomplete(){
  $.ajax({
    url: '/listings/ajax_search',
    type: 'GET',
    data: {query: $("#listing_term").val()}, //takes the form data and authenticity toke and converts it into a standard URL
    dataType: 'json', //specify what type of data you're expecting back from the servers
    error: function() {
        console.log("Something went wrong");
    },
    success: function(data) {
      console.log(data)
      $("#list").html("");

      data.forEach(function(element) {
        var option = document.createElement("option");
        option.value = element;
        console.log(option)

        //append option to list
        $("#list").append(option);
      });
    }
  });
}
