class Reminder < ApplicationRecord
  belongs_to :user

  after_create :repeat_notif

  def repeat_notif
    RepeatNotif.set(wait_until: self.strike).perform_later(self.id)
  end
end
