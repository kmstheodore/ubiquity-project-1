require "discordrb"
class DiscordBotService
  def initialize
    @bot = Discordrb::Bot.new token: ENV["13747514435098dce22c5f14a0e2844c31c197285c878a675e0faa2ded77eb6a"]
  end

  def notify_user_signup(user)
    channel_id = ENV["1012674351553859606"]
    @bot.send_message(channel_id, "New user signed up: #{user.email}")
  end
end
