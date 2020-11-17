class MakersMailer < ApplicationMailer
  default from: "Plataforma Makers <#{ENV['TEC_USERNAME']}>"

  def status_email(reservation)
    @reservation = reservation
    mail(to: @reservation.user.email, subject: 'Tu reservación ha sido ' + I18n.t("activerecord.models.reservations.attributes.status.#{@reservation.status}", locale: :es), 'X-Priority': '1')
  end
end
