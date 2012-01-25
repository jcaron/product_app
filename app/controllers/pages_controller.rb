class PagesController < ApplicationController
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
