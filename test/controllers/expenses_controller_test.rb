require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @expense = expenses(:one)
    sign_in @user
  end

  test "should get index" do
    get expenses_url
    assert_response :success
  end

  test "should get new" do
    get new_expense_url
    assert_response :success
  end

  test "should create expense" do
    assert_difference("Expense.count") do
      post expenses_url, params: {
        expense: {
          amount: @expense.amount,
          category_id: @expense.category_id,
          date: @expense.date,
          description: @expense.description,
          title: @expense.title
        }
      }
    end

    assert_redirected_to expenses_url
  end

  test "should show expense" do
    get expense_url(@expense)
    assert_response :success
  end

  test "should get edit" do
    get edit_expense_url(@expense)
    assert_response :success
  end

  test "should update expense" do
    patch expense_url(@expense), params: {
      expense: {
        amount: @expense.amount,
        category_id: @expense.category_id,
        date: @expense.date,
        description: @expense.description,
        title: @expense.title
      }
    }
    assert_redirected_to expenses_url
  end

  test "should destroy expense" do
    assert_difference("Expense.count", -1) do
      delete expense_url(@expense)
    end

    assert_redirected_to expenses_url
  end

  test "should not access other user's expenses" do
    other_expense = expenses(:three)  # belongs to users(:two)
    get expense_url(other_expense)
    assert_response :not_found
  end

  test "should search expenses" do
    get expenses_url, params: { query: @expense.title.downcase }
    assert_response :success
    assert_select "div", text: /#{@expense.title}/
  end
end
