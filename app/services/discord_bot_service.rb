class DiscordBotService
  def initialize
    @bot = Discordrb::Bot.new token: ENV["DISCORD_BOT_TOKEN"]
  end

  def notify_new_reminder(reminder)
    channel_id = ENV["DISCORD_CHANNEL_ID"]
    @bot.send_message(channel_id, "Hello! A new reminder has been created: #{reminder.name}")
  end
end
