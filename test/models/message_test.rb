require "test_helper"

class MessageTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @conversation = conversations(:one)
    @message = messages(:one)
  end

  test "should be valid" do
    assert @message.valid?
  end

  test "should require user" do
    @message.user = nil
    assert_not @message.valid?
  end

  test "should require conversation" do
    @message.conversation = nil
    assert_not @message.valid?
  end

  test "should require content" do
    @message.content = nil
    assert_not @message.valid?
  end

  test "should not allow empty content" do
    @message.content = ""
    assert_not @message.valid?
  end

  test "should belong to conversation" do
    assert_equal @conversation, @message.conversation
  end

  test "should belong to user" do
    assert_equal @user, @message.user
  end
end
