require "http"

class HuggingFaceService
  def initialize
    @api_key = Rails.application.credentials.huggingface.api_key
    @api_url = "https://api-inference.huggingface.co/models/facebook/blenderbot-400M-distill"
  end

  def chat(message)
    response = HTTP.auth("Bearer #{@api_key}")
                  .post(@api_url, json: { inputs: message })

    if response.status.success?
      (JSON.parse(response.body.to_s) || []).map { |data| data["generated_text"] }.join(" ")
    else
      "I'm sorry, I couldn't process that request."
    end
  rescue StandardError => e
    Rails.logger.error("HuggingFace API Error: #{e.message}")
    "Sorry, there was an error processing your request."
  end
end
