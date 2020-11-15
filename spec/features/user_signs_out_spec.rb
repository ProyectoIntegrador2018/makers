require 'spec_helper'

feature 'User signs out' do
  scenario 'successfully' do
    user = create :user
    sign_in_as user
    visit root_path
    click_on 'Cerrar sesión'

    expect(current_path).to eq(root_path)
  end
end
