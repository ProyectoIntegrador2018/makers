require 'spec_helper'

feature 'User signs in' do
  context 'with email' do
    scenario 'successfully' do
      create :user, email: 'foo@itesm.mx', given_name: 'Test', last_name: 'User'
      visit new_user_session_path

      fill_in 'user_email', with: 'foo@itesm.mx'
      fill_in 'user_password', with: '12345678'
      click_button 'Iniciar sesión'

      expect(page).to have_css('a', text: 'Test User')
    end

    scenario 'with wrong password' do
      create :user, email: 'foo@itesm.mx', given_name: 'Test User' 
      visit new_user_session_path 

      fill_in 'user_email', with: 'foo@itesm.mx'
      fill_in 'user_password', with: 'wrong-password'
      click_button 'Iniciar sesión'

      expect(page).to have_css('.alert', text: 'Correo o contraseña inválidos')
    end

    scenario 'and is not confirmed' do
      create :user, :unconfirmed, email: 'foo@itesm.mx'

      visit new_user_session_path
      fill_in 'user_email', with: 'foo@itesm.mx'
      fill_in 'user_password', with: '12345678'
      click_button 'Iniciar sesión'

      expect(page).to have_css('.alert', text: 'Debes confirmar tu cuenta para continuar')
    end
  end
end
