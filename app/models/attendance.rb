class Attendance < ApplicationRecord

  belongs_to :user
  belongs_to :event

  after_create :new_attendee

  def new_attendee
   AdminMailer.new_attendee(self).deliver_now
  end

end
