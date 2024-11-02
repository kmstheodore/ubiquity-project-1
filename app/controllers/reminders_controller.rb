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
  private

  def reminder_params
    params.require(:reminder).permit(:name, :description)
  end
end
