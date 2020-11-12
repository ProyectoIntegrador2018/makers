class ApplicationMailer < ActionMailer::Base
  default from: 'Plataforma Makers <' + ENV['TEC_USERNAME'] + '>'
  layout 'mailer'
end
