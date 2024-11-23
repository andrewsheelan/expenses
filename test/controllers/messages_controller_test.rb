require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @conversation = conversations(:one)
    @message = messages(:one)
    sign_in @user
  end

  test "should not create empty message" do
    assert_no_difference("Message.count") do
      post conversation_messages_url(@conversation), params: {
        message: { content: "" }
      }
    end

    assert_response 302
  end

  test "should not create message in other user's conversation" do
    other_conversation = conversations(:two)  # belongs to users(:two)

    assert_difference("Message.count") do
      post conversation_messages_url(other_conversation), params: {
        message: { content: "Test message" }
      }
    end
  end
end
