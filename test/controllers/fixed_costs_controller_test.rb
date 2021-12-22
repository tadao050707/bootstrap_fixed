require 'test_helper'

class FixedCostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fixed_costs_index_url
    assert_response :success
  end

  test "should get new" do
    get fixed_costs_new_url
    assert_response :success
  end

  test "should get edit" do
    get fixed_costs_edit_url
    assert_response :success
  end

  test "should get show" do
    get fixed_costs_show_url
    assert_response :success
  end

end
