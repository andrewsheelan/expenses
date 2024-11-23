class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :content, presence: true

  after_create_commit :broadcast_message

  private

  def broadcast_message
    ConversationChannel.broadcast_to(
      conversation,
      {
        html: ApplicationController.renderer.render(
          partial: "conversations/conversation_messages",
          locals: {
            conversation: conversation,
            current_user: user
          }
        )
      }
    )
  end
end
