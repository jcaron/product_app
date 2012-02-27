require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:email => "bob@not-real.com", :password => "swordfish", :password_confirmation => "swordfish"}
  end

  it 'should create a new user given valid attributes' do
    user = User.new @attr
    user.save.should be_true
  end

  describe "associations" do
    it 'should have one cart' do
      User.respond_to? :cart
    end

    it 'should have the right cart' do
      user = User.create! @attr
      cart = user.build_cart
      user.cart.should eq cart
    end
  end

  describe "validations" do
    it 'should require a email' do
      user = User.new(@attr.merge(:email => ''))
      user.should_not be_valid
    end

    it 'should require the email to be of the right format' do
      user = User.new(@attr.merge(:email => 'gibberish'))
      user.should_not be_valid
    end

    it 'should require a password' do
      user = User.new(@attr.merge(:password => ''))
      user.should_not be_valid
    end

    it 'should reject long passwords' do  # > 128
      long_pass = 'a'*129
      user = User.new(@attr.merge(:password => long_pass))
      user.should_not be_valid
    end

    it 'should reject short passwords' do # < 6
      short_pass = 'a'*5
      user = User.new(@attr.merge(:password => short_pass))
      user.should_not be_valid
    end

    it 'should require a matching confirmation' do
      user = User.new(@attr.merge(:password_confirmation => 'fishsword'))
      user.should_not be_valid
    end
  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it 'should have a encrypted password attribute' do
      User.respond_to? :encrypted_password
    end

    it 'should set the encrypted password' do
      @user.encrypted_password.should_not be_blank
      @user.encrypted_password.should_not eq @attr[:password]
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

