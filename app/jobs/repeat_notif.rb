class RepeatNotif < ApplicationJob
  queue_as :default

  def perform(reminder_id)
    reminder = Reminder.find(reminder_id)
    DiscordBotService.new.notifier(reminder)
  end
end
