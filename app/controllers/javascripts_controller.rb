class JavascriptsController < ApplicationController
  def dynamic_sub_categories
    @sub_categories = SubCategory.find(:all)
  end
end
