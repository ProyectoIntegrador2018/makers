require 'spec_helper'

feature 'User creates reservation', js: true do
  before do
    @lab = create :lab, :with_equipment
    @lab_space = LabSpace.first
    @equipment = Equipment.first

    @user = create :user
    sign_in_as @user
    visit lab_lab_space_equipment_path(@lab, @lab_space, @equipment)
  end

  scenario 'successfully' do
    calendar_select tomorrow.at_noon, tomorrow.at_noon + 1.hour
    
    within('#reservationModal') do
      sleep(1)  # Modal takes a bit to show
      click_button 'Reservar'
    end
    expect(page).to have_selector('.fc-timegrid-event-harness', count: 1)
    expect(first_reservation.user).to eq(@user)
    expect(first_reservation.equipment).to eq(@equipment)

    expect(emails.count).to eq(1)
    expect(last_email.to).to eq [@user.email]
    expect(last_email.subject).to eq 'Tu reservación ha sido puesta en Pendiente'
  end

  scenario 'that exceeds equipment max usage ' do
    # Default max usage is 5h
    calendar_select tomorrow.at_noon, tomorrow.at_noon + 6.hour

    msg = accept_alert do
      within('#reservationModal') do
        click_button 'Reservar'
      end
    end

    expect(msg).to have_text('El equipo necesita un tiempo de descanso')
    expect(page).not_to have_selector('.fc-timegrid-event-harness')
    expect(first_reservation).to eq(nil)
  end

  scenario 'in the past' do
    last_week_slot = tomorrow.at_noon - 1.week
    calendar_select last_week_slot, last_week_slot + 1.hour

    msg = accept_alert do
      within('#reservationModal') do
        click_button 'Reservar'
      end
    end

    expect(msg).to have_text('La reservación no puede estar en el pasado')
    expect(page).not_to have_selector('.fc-timegrid-event-harness')
    expect(first_reservation).to eq(nil)
  end

  # TODO: Enable test when bug is fixed
  # scenario 'that reaches max usage (and prompts cooldown)' do
  #   Timecop.freeze Time.now.beginning_of_day do
  #     start_slot = find('[data-time="06:00:00"]:last-child')
  #     end_slot = find('[data-time="10:30:00"]:last-child')
  #     start_slot.drag_to end_slot

  #     within('#reservationModal') do
  #       click_button('Reservar')
  #     end

  #     reload_page ## TODO: Remove when fix from alex
  #     puts Reservation.count
  #     expect(page).to have_selector('.fc-timegrid-event-harness', count: 2)
  #     expect(first_reservation.user).to eq(@user)
  #     expect(first_reservation.equipment).to eq(@equipment)
  #   end
  # end
end
