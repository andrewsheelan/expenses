require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @category = categories(:one)
    sign_in @user
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    assert_no_difference("Category.count") do
      post categories_url, params: { category: { description: @category.description, name: @category.name } }
    end

    assert_response :unprocessable_entity
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { description: @category.description, name: @category.name } }
    assert_redirected_to category_url(@category)
  end

  test "should destroy category" do
    assert_no_difference("Category.count") do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
  end

  test "should not access other user's categories" do
    other_category = categories(:three)  # belongs to users(:two)
    get category_url(other_category)
    assert_response :not_found
  end

  test "should search categories" do
    get categories_url, params: { query: @category.name.downcase }
    assert_response :success
    assert_select "div", text: /#{@category.name}/
  end
end
