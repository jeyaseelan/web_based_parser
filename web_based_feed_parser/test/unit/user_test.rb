require File.dirname(__FILE__) + '/../test_helper'


class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  def test_user #test to check the new user creation
  new_user=nil
  assert_nil new_user ,"Contains some data. But should not"
  new_user=User.new
  assert_not_nil new_user ,"No data in it.But expected!"
  assert !new_user.save,"User record created with empty fields"
  initial_count=User.count
  new_user=User.new(:name=>"sample",:mobile=>"9099909090",:email=>"xxx@email.com",:user_name=>"jeyaseelan")
  assert new_user.save ,"User record was not created"
  present_count=User.count
  assert_equal initial_count+1,present_count,"New Record was not created"
  assert new_user.destroy
  first_user=users(:users_001)
  second_user=users(:users_002)
  assert_not_equal first_user.email, second_user.email, "Email ids should not be same"
  assert_not_equal first_user.mobile, second_user.mobile, "Mobile Number should not be same"
  assert_not_equal first_user.user_name, second_user.user_name, "User Name should not be same"
  assert_instance_of User, first_user, "It is not a user record"
  first_user.user_name=second_user.user_name
  assert !first_user.save ,"saved with duplicate user names but should not"
  first_user.destroy
  second_user.destroy
  assert_equal 0,User.count,"Not all data deleted"
  end
  
 
   
  
end
