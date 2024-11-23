require "test_helper"

class ConversationTest < ActiveSupport::TestCase
  def setup
    @user1 = users(:one)
    @user2 = users(:two)
    @conversation = conversations(:one)
  end

  test "should be valid" do
    assert @conversation.valid?
  end

  test "should require sender" do
    @conversation.sender = nil
    assert_not @conversation.valid?
  end

  test "should require recipient" do
    @conversation.recipient = nil
    assert_not @conversation.valid?
  end

  test "should enforce unique sender-recipient pairs" do
    duplicate_conversation = @conversation.dup
    assert_not duplicate_conversation.valid?
  end

  test "should find conversation between users" do
    found_conversation = Conversation.between(@user1.id, @user2.id).last
    assert_equal @conversation, found_conversation
  end

  test "should get other user" do
    assert_equal @user2, @conversation.other_user(@user1)
    assert_equal @user1, @conversation.other_user(@user2)
  end
end
