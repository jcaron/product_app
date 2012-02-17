$(document).ready(function() {
  var original_select = new Array();
  original_select = $("#product_sub_category_id option");
  var category_id = $("#product_category_id").val();
  $("#product_sub_category_id").html("");
  update_select();

  $("#product_category_id").change(function() {
    // When the Category select box's value is changed, get the value for the 
    // new selected option & save it to category_id
    category_id = $("#product_category_id").val();
    $("#product_sub_category_id").html("");
    update_select();
  });
  
  function update_select() {
    $(original_select).each(function() {
      if ($(this).attr('rel') == category_id || $(this).attr('rel') == "default"){
        $("#product_sub_category_id").append(this);
      }
    });
  };
});