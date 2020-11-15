require 'spec_helper'

feature 'User confirms email address' do
  scenario 'successfully' do
    create :user, :unconfirmed, confirmation_token: '12345'
    visit user_confirmation_path(confirmation_token: '12345')
    expect(page).to have_css('.alert-primary', text: 'Tu cuenta fue confirmada exitosamente')
  end

  scenario 'with wrong confirmation_token' do
    create :user, :unconfirmed, confirmation_token: '12345'
    visit user_confirmation_path(confirmation_token: 'wrong_token')
    expect(page).to have_css('.alert-danger', text: 'El token de confirmación es inválido')
  end
end
