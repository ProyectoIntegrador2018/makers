require 'spec_helper'

feature 'User signs up' do
  context 'with email' do
    scenario 'successfully' do
      sign_up
      expect(page).to have_selector('.alert-primary', text: 'Registro exitoso')
    end

    scenario 'and an non-institutional email' do
      sign_up(email: 'foo@bar.com')
      expect(page).to have_selector('.alert-danger', text: 'El correo es inválido. Utiliza tu correo @itesm.mx or @tec.mx')
    end

    scenario 'and a short password' do
      sign_up(password: 'foo')
      expect(page).to have_selector('.alert-danger', text: 'is too short (minimum is 6 characters)')
    end

    scenario 'and a non-matching password confirmation' do
      sign_up(password: 'another pw')
      expect(page).to have_selector('.alert-danger', text: 'La contraseña no coincide')
    end

    scenario 'that\'s already taken by another user' do
      create :user, email: 'hola@itesm.mx'
      sign_up
      expect(page).to have_selector('.alert-danger', text: 'has already been taken')
    end
  end
end
