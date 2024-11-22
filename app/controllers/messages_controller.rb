class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params.merge(user: current_user))

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @conversation }
      end
    else
      redirect_to @conversation, alert: "Failed to send message."
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
