class CheckerJob
  include Sidekiq::Job

  def perform(reminder_id)
    DiscordBotService.new.notifier(reminder_id)
    # ha
  end
end
