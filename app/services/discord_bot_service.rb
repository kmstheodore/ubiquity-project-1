class DiscordBotService
  def initialize
    @bot = Discordrb::Bot.new token: ENV["DISCORD_BOT_TOKEN"]
  end

  def notify_new_reminder(reminder)
    user = reminder.user
    discord_id = user.discord_id
    @bot.user(discord_id).pm("Hello! A new reminder has been created: #{reminder.name}")
  end

  def notifier(reminder_id)
    reminder = Reminder.find(reminder_id)
    user = reminder.user
    discord_id = user.discord_id
    current_time = Time.now
    until current_time >= reminder.strike
      current_time = Time.now
      @bot.user(discord_id).pm("It's time to complete: #{reminder.name}")
      sleep 20.seconds
    end
  end
end
