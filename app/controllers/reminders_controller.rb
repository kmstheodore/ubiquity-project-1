class RemindersController < ApplicationController
  before_action :authenticate_user!
  def show
    @reminder = Reminder.find(params[:id])
  end

  def index
    @reminders = current_user.reminders.all
  end

  def new
    @reminder = current_user.reminders.build
  end

  def create
    @reminder = current_user.reminders.build(reminder_params)
    if @reminder.save
      # DiscordBotService.new.notify_new_reminder(@reminder)
      # CheckerJob.perform_at(@reminder.strike - 60.seconds, @reminder.id)
      redirect_to root_path
    end
  end

  def edit
    @reminder = Reminder.find(params[:id])
  end

  def update
    @reminder = Reminder.find(params[:id])

    if @reminder.update(reminder_params)
      redirect_to @reminder
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    redirect_to root_path, status: :see_other
  end

  def toggle_complete
    @reminder = Reminder.find(params[:id])
    @reminder.update(complete: !@reminder.complete, counter: @reminder.counter + 1)
    redirect_to root_path
  end



  private

  def send_push_notification(reminder)
    fcm_token = current_user.fcm_token
    Rails.logger.info("FCM token: #{fcm_token.inspect}")
    return unless fcm_token

    fcm = FCM.new(ENV["FCM_SERVER_KEY"])
    options = {
      notification: {
        title: "New Reminder Created",
        body: "Reminder: #{reminder.name}",
        icon: "/path/to/icon.png",
        click_action: reminder_url(reminder)
      }
    }

    response = fcm.send([ fcm_token ], options)
    Rails.logger.info("FCM response: #{response[:status_code]} - #{response[:body]}")
    if response[:status_code] != 200
      Rails.logger.error("FCM error: #{response[:body]}")
    end
  end

  def reminder_params
    params.require(:reminder).permit(:name, :strike, :description, :complete, :counter, :active, :repeat)
  end
end
