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
      DiscordBotService.new.notify_new_reminder(@reminder)
      CheckerJob.perform_at(@reminder.strike, @reminder.id)
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

  def reminder_params
    params.require(:reminder).permit(:name, :strike, :description, :complete, :counter, :active, :repeat)
  end
end
