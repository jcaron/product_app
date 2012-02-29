class PagesController < ApplicationController
  before_filter :authenticate_user!, :only => [:new]

  def home
    @title = 'Home'
  end

  def about
    @title = 'About'
  end

  def help
    @title = 'Help'
  end

  def new
    @title = 'Forms root'
  end
end
