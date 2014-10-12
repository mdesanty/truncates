require 'test_helper'

class TruncatesTest < ActiveSupport::TestCase

  setup do
    setup_db 
    @customer = TruncatesCustomer.new
    @user = TruncatesUser.new
  end
  
  teardown do 
    teardown_db
  end
  
  test "should truncate customer first_name to 255 characters before validation" do 
    first_name = "m" * 270
    expected_truncated_value= "m" * 255 
    
    @customer.first_name = first_name
    
    assert_equal(first_name, @customer.first_name)
    assert_equal(true, @customer.valid?)
    assert_equal(expected_truncated_value, @customer.first_name)
  end
  
  test "should truncate user first_name to 255 characters when set" do
    first_name = "m" * 270
    expected_truncated_value = "m" * 255
    
    @user.first_name = first_name
    assert_equal(expected_truncated_value, @user.first_name)
  end
  
  test "should truncate customer middle_name to 5 characters before validation" do 
    middle_name = "johnny"
    expected_truncated_value = "johnn"
    
    @customer.middle_name = middle_name
    
    assert_equal(middle_name, @customer.middle_name)
    assert_equal(true, @customer.valid?)
    assert_equal(expected_truncated_value, @customer.middle_name)
  end
  
  test "should truncate user middle_name to 5 characters when set" do 
    middle_name = "johnny"
    expected_truncated_value = "johnn"
    
    @user.middle_name = middle_name
    assert_equal(expected_truncated_value, @user.middle_name)
  end
  
  test "shold truncate customer last_name to 10 characters and replace last characters with ... before validation" do
    last_name = "longlastname"
    expected_truncated_value = "longlas..."
    
    @customer.last_name = last_name
    
    assert_equal(last_name, @customer.last_name)
    assert_equal(true, @customer.valid?)
    assert_equal(expected_truncated_value, @customer.last_name)
  end
  
  test "should truncate user last_name to 10 characters and replace last characters with ... when set" do 
    last_name = "longlastname"
    expected_truncated_value = "longlas..."
    
    @user.last_name = last_name
    assert_equal(expected_truncated_value, @user.last_name)
  end
  
  test "should truncate customer city to 5 characters when set" do
    city = "cityname"
    expected_truncated_value = "cityn"
    
    @customer.city = city
    assert_equal(expected_truncated_value, @customer.city)
  end
  
  test "should truncate user city to 5 characters when set" do 
    city = "cityname"
    expected_truncated_value = "cityn"
    
    @user.city = city
    assert_equal(expected_truncated_value, @user.city)
  end
  
  test "should truncate customer state to 5 characters before validation" do 
    state = "Virginia"
    expected_truncated_value = "Virgi"
    
    @customer.state = state
    
    assert_equal(state, @customer.state)
    assert_equal(true, @customer.valid?)
    assert_equal(expected_truncated_value, @customer.state)
  end
  
  test "should truncate user state to 5 characters when set" do 
    state "Virginia"
    expected_truncated_value = "Virgi"
    
    @user.state = state
    assert_equal(expected_truncated_value, @user.state)
  end
end