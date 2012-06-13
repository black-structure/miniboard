require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  User.delete_all
  
  test "password_length" do
    user = User.new(:username => 'test1', :password => '12345', :password_confirmation => '12345')
    assert !user.save
  end
  
  test "confirmation" do
    user = User.new(:username => 'test2', :password => '123456', :password_confirmation => '133456')
    assert !user.save
  end
  
  test "uniqueness" do
    user1 = User.new(:username => 'test3', :password => '123456', :password_confirmation => '123456')
    user2 = User.new(:username => 'test3', :password => '123456', :password_confirmation => '123456')
    assert user1.save
    assert !user2.save
  end
  
end
