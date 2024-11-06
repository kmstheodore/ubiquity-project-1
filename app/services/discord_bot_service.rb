class DiscordBotService
  def initialize
    @bot = Discordrb::Bot.new token: ENV["DISCORD_BOT_TOKEN"]
  end

  def notify_new_reminder(reminder)
    user = reminder.user
    discord_id = user.discord_id
    @bot.user(discord_id).pm("Hello! A new reminder has been created: #{reminder.name}")
  end

  def notifier(reminder)
    user = reminder.user
    discord_id = user.discord_id
    discord_user = @bot.user(discord_id)

    if discord_user
      discord_user.pm("Hello! A new reminder has been created: #{reminder.name}")
    else
      Rails.logger.error "Discord user with ID #{discord_id} not found"
    end
  end
end
