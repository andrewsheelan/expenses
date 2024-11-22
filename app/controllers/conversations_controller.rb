class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show]

  def index
    @conversations = current_user.conversations
    @users = User.where.not(id: current_user.id)
  end

  def show
    @messages = @conversation.messages.includes(:user)
    @message = Message.new
  end

  def create
    @conversation = Conversation.between(current_user.id, params[:recipient_id])
                              .first_or_create!(sender: current_user,
                                              recipient_id: params[:recipient_id])
    redirect_to @conversation
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
    unless @conversation.sender_id == current_user.id || 
           @conversation.recipient_id == current_user.id
      redirect_to root_path, alert: 'Not authorized to view this conversation.'
    end
  end
end
