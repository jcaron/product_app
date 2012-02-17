$(document).ready(function() {
  //if there are these single select boxes on the page, use chosen on them
  $(".category_chosen").each(function() {
    $(this).data("placeholder", "Select category").chosen();
  });
  $(".product_chosen").each(function() {
    $(this).data("placeholder", "Select product").chosen();
  });
});
