require 'spec_helper'

feature 'User cancels reservation', js: true do
  before do
    @user = create :user
    @lab = create :lab, :with_equipment
    @lab_space = LabSpace.first
    @equipment = Equipment.first
    create :available_hour, equipment: @equipment, day_of_week: Date.today.wday

    sign_in_as @user
  end

  scenario 'that they own' do
    reservation = create :reservation, user: @user, equipment: @equipment

    visit lab_lab_space_equipment_path(@lab, @lab_space, @equipment)
    find('.fc-timegrid-event-harness').click

    accept_alert do
      click_button 'Cancelar'
    end

    expect(page).to have_selector('#detailModal', visible: false)
    expect(page).not_to have_selector('.fc-timegrid-event-harness')

    expect(emails.count).to eq(1)
    expect(last_email.subject).to eq 'Tu reservación ha sido Cancelada'
    expect(last_email.to).to eq [@user.email]
  end
end
