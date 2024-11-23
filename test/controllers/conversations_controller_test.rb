require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @other_user = users(:two)
    @conversation = conversations(:one)
    @message = messages(:one)
    sign_in @user
  end

  test "should get index" do
    get conversations_url
    assert_response :success
  end

  test "should get show" do
    get conversation_url(@conversation)
    assert_response :success
  end

  test "should get search" do
    get search_conversations_url
    assert_response :success
  end

  test "should search conversations with query" do
    get search_conversations_url, params: { query: @message.content.downcase }
    assert_response :success
    assert_select "div", text: /#{@message.content}/
  end

  test "should handle empty search query" do
    get search_conversations_url, params: { query: "" }
    assert_response :success
    assert_select "h3", "Start searching"
  end

  test "should handle no results" do
    get search_conversations_url, params: { query: "nonexistent message content" }
    assert_response :success
    assert_select "h3", "No results found"
  end
end
