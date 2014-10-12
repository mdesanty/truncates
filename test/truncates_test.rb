require 'test_helper'

class TruncatesTest < ActiveSupport::TestCase
  setup do 
    setup_db
    @customer = TruncatesCustomer.new
  end
  
  teardown do 
    teardown_db
  end
  
  test "should truncate first_name to 255 characters before validation" do 
    first_name = "m" * 270
    expected_truncated_value= "m" * 255 
    
    @customer.first_name = first_name
    
    assert_equal(first_name, @customer.first_name)
    assert_equal(true, @customer.valid?)
    assert_equal(expected_truncated_value, @customer.first_name)
  end
  
  test "should truncate middle_name to 5 characters before validation" do 
    middle_name = "johnny"
    expected_truncated_value = "johnn"
    
    @customer.middle_name = middle_name
    
    assert_equal(middle_name, @customer.middle_name)
    assert_equal(true, @customer.valid?)
    assert_equal(expected_truncated_value, @customer.middle_name)
  end
  
  test "shold truncate last_name to 10 characters and replace last characters with ... before validation" do
    last_name = "longlastname"
    expected_truncated_value = "longlas..."
    
    @customer.last_name = last_name
    
    assert_equal(last_name, @customer.last_name)
    assert_equal(true, @customer.valid?)
    assert_equal(expected_truncated_value, @customer.last_name)
  end
  
  test "should truncate city to 5 characters when set" do
    city = "cityname"
    expected_truncated_value = "cityn"
    
    @customer.city = city
    assert_equal(expected_truncated_value, @customer.city)
  end
  
  test "should truncate state to 5 characters before validation" do 
    state = "Virginia"
    expected_truncated_value = "Virgi"
    
    @customer.state = state
    
    assert_equal(state, @customer.state)
    assert_equal(true, @customer.valid?)
    assert_equal(expected_truncated_value, @customer.state)
  end
end