class AdminMailer < ApplicationMailer

  default from: 'no-reply@mutmutbrite.com'

 def new_attendee(attendance)

   @attendance = attendance
   @event = @attendance.event
   @admin = @event.user
   @attendee = @attendance.user

   mail(to: @admin.email, subject: 'Nouveau participant à ton événement')

 end

end
