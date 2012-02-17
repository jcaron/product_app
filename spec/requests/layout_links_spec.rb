require 'spec_helper'

describe "LayoutLinks" do
  it 'should have a Home page' do
    get '/'
    response.should have_selector('title', :content => 'Home')
  end

  it 'should have a New page' do
    get '/new'
    response.should have_selector('title', :content => 'Forms')
  end

  it 'should have a Help page' do
    get '/help'
    response.should have_selector('title', :content => 'Help')
  end

  it 'should have a About page' do
    get '/about'
    response.should have_selector('title', :content => 'About')
  end

  it 'should have the right links on the layout' do
    visit root_path
    click_link "Categories"
    response.should have_selector('title', :content => 'Category')
    click_link "Products"
    response.should have_selector('title', :content => 'All products')
    click_link "New"
    response.should have_selector('title', :content => 'Forms')
    click_link "Help"
    response.should have_selector('title', :content => 'Help')
    click_link "About"
    response.should have_selector('title', :content => 'About')
    click_link "Home"
    response.should have_selector('title', :content => 'Home')
    click_link "Get started!"
    response.should have_selector('title', :content => 'Forms')
  end
end
