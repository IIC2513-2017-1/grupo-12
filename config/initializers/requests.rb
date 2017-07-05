# frozen_string_literal: true

# Main class to handle connections to telegram bot
class Telegram
  def initialize
    @path = "https://api.telegram.org/bot#{ENV['BOT_TOKEN']}"
    @client = HTTPClient.new
    @url = 'https://dreamfunder-uc.herokuapp.com/api/v1/'
    @hook = 'telegram'
    set_webhook
  end

  def send_message(chat_id, text)
    api_url = @path + '/sendMessage'
    data = { "chat_id": chat_id, "text": text }
    # NEED TO CHANGE IT FOR ASYNCHRONOUS REQUESTS!!!!
    req = @client.request(:post,
                          api_url,
                          query: nil,
                          body: data,
                          extheader: { "content_type": 'application/json' })
    # loop do
    # break if req.finished?
    # print '.'
    # sleep 1
    # end
    # content = JSON.parse req.pop.content.read
    # puts content
    # print("sent message to {} !".format(chat_id))
  end

  def set_webhook
    data = { "url": @url + @hook }
    x = @client.request(:post, @path + '/setWebhook', body: data)
    puts x.body
  end
end

BOT = Telegram.new
