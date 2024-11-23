require "application_system_test_case"

class ExpensesTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    @expense = expenses(:one)
    @category = categories(:one)
    sign_in_as(@user)
  end

  test "visiting the index" do
    visit expenses_url
    assert_selector "h1", text: "Expenses"
  end
end
