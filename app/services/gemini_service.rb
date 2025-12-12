require "faraday"
require "json"

class GeminiService
  API_ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent".freeze

  def initialize(message = nil)
    @message = message.to_s if message
    @api_key = ENV["GEMINI_API_KEY"].to_s.strip
    
    raise "GEMINI_API_KEY is not configured" if @api_key.blank?
  end

  # For chat - simple text generation
  def call
    return "Повідомлення порожнє" if @message.blank?

    begin
      response = make_request(@message)
      
      if response.success?
        parse_response(response.body)
      else
        Rails.logger.error("Gemini API error: #{response.status} - #{response.body}")
        "На жаль, виникла помилка. Спробуйте ще раз."
      end
    rescue StandardError => e
      Rails.logger.error("GeminiService error: #{e.message}")
      "На жаль, виникла помилка. Спробуйте ще раз."
    end
  end

  # For product analysis
  def self.analyze_product(product_name, description = "")
    service = new
    prompt = build_analysis_prompt(product_name, description)
    
    begin
      response = service.make_request(prompt)
      
      if response.success?
        service.parse_response(response.body)
      else
        { error: "Помилка при аналізі товару" }
      end
    rescue StandardError => e
      Rails.logger.error("Product analysis error: #{e.message}")
      { error: "Помилка при аналізі товару" }
    end
  end

  private

  def self.build_analysis_prompt(product_name, description)
    current_info = description.present? ? "Поточний опис: #{description}" : "Опису немає"
    
    <<~PROMPT
      Проаналізуй товар для косметики/здоров'я українською мовою.
      
      Назва товару: #{product_name}
      #{current_info}
      
      Відповідь у форматі JSON (тільки JSON, без додаткового тексту):
      {
        "characteristics": ["характ. 1", "характ. 2", "характ. 3"],
        "benefits": ["користь 1", "користь 2", "користь 3"],
        "usage": "Інструкція (2-3 речення)"
      }
    PROMPT
  end

  def make_request(prompt)
    url = "#{API_ENDPOINT}?key=#{@api_key}"
    
    payload = {
      contents: [{
        parts: [{ text: prompt }]
      }]
    }

    Faraday.post(url) do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = payload.to_json
    end
  end

  def parse_response(body)
    data = JSON.parse(body)
    
    text = data.dig("candidates", 0, "content", "parts", 0, "text")
    return text.strip if text.present?
    
    "Не вдалося отримати відповідь"
  rescue JSON::ParserError => e
    Rails.logger.error("JSON parse error: #{e.message}")
    "Помилка при обробці відповіді"
  end
end