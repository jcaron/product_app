<% @cart ||= current_cart %>
$("#cart_form").html("");
$(".cart_count").html("<%= escape_javascript pluralize(@cart.total_items_in_cart, "item") %>");
$(".cart_cost").html("<%= escape_javascript number_to_currency(@current_cart.total_price) %>");
