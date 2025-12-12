class ChatController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  # GET /chat – відобразити чат‑інтерфейс
  def index
  end

  # POST /chat – прийняти повідомлення користувача та повернути відповідь Gemini
  def create
    user_message = params[:message].to_s
    result = ChatbotService.new(user_message).response
    render json: { text: result[:text], url: result[:url] }
  end

end
