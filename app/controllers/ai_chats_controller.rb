class AiChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    response = HuggingFaceService.new.chat(params[:message])
    render json: { message: response }
  end
end
