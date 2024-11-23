class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find(params[:conversation_id])
    stream_for conversation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    conversation = Conversation.find(data["conversation_id"])

    message = conversation.messages.create!(
      content: data["content"],
      user: current_user
    )
  end
end
