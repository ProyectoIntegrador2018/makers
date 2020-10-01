class MakersMailer < ApplicationMailer
  default from: 'Plataforma Makers <makersprogram-noreply@tec.mx>'

  def cancellation_email(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: 'Tu reservación ha sido rechazada.', 'X-Priority': '1')
  end
end
