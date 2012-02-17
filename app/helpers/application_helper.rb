module ApplicationHelper
  def title
    base_title = "Product Application"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def current_cart
    session[:cart_id] ||= Cart.create!.id
    @current_cart ||= Cart.find_or_create_by_id(session[:cart_id])
  end
end
