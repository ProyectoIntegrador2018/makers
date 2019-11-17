class MakersMailer < ApplicationMailer
  default from: 'makersprogram-noreply@tec.mx'

  def cancellation_email(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: 'Tu reservación ha sido rechazada.')
  end
end
