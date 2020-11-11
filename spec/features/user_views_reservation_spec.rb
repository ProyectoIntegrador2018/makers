require 'spec_helper'

feature 'User views reservation', js: true do
  before do
    @user = create :user
    @lab = create :lab, :with_equipment
    @lab_space = LabSpace.first
    @equipment = Equipment.first
    create :available_hour, equipment: @equipment, day_of_week: Date.today.wday

    sign_in_as @user
  end

  context 'that they own' do
    scenario 'and is pending' do
      @reservation = create :reservation, :pending, user: @user, equipment: @equipment

      visit lab_lab_space_equipment_path(@lab, @lab_space, @equipment)
      find('.fc-timegrid-event-harness').click

      expect(find('#cancelBtn')).to be_visible
      expect(page).to have_selector('#rejectBtn', visible: false)
      expect(page).to have_selector('#acceptBtn', visible: false)

      expect(find('#detailUserField')).to have_text(@user.name)
      expect(find('#detailStatusField')).to have_text('Pendiente')
      expect(find('#detailPurposeField')).to have_text('Academic')
      expect(find('#detailCommentField')).to have_text(@reservation.comment)
      expect(find('#detailDateField')).to have_text(readable_date_range(@reservation.start_time, @reservation.end_time))
    end

    scenario 'and is confirmed' do
      @reservation = create :reservation, :confirmed, user: @user, equipment: @equipment

      visit lab_lab_space_equipment_path(@lab, @lab_space, @equipment)
      find('.fc-timegrid-event-harness').click

      expect(find('#cancelBtn')).to be_visible
      expect(page).to have_selector('#rejectBtn', visible: false)
      expect(page).to have_selector('#acceptBtn', visible: false)

      expect(find('#detailUserField')).to have_text(@user.name)
      expect(find('#detailStatusField')).to have_text('Confirmada')
      expect(find('#detailPurposeField')).to have_text('Academic')
      expect(find('#detailCommentField')).to have_text(@reservation.comment)
      expect(find('#detailDateField')).to have_text(readable_date_range(@reservation.start_time, @reservation.end_time))
    end

    scenario 'and is rejected' do
      @reservation = create :reservation, :rejected, user: @user, equipment: @equipment
      visit lab_lab_space_equipment_path(@lab, @lab_space, @equipment)

      expect(page).not_to have_selector('.fc-timegrid-event-harness')
    end

    scenario 'and is cancelled' do
      @reservation = create :reservation, :cancelled, user: @user, equipment: @equipment
      visit lab_lab_space_equipment_path(@lab, @lab_space, @equipment)

      expect(page).not_to have_selector('.fc-timegrid-event-harness')
    end
  end

  context 'that another user owns' do
    before do
      @user2 = create :user
    end

    scenario 'and is pending' do
      create :reservation, :pending, user: @user2, equipment: @equipment
      visit lab_lab_space_equipment_path(@lab, @lab_space, @equipment)

      expect(page).not_to have_selector('.fc-timegrid-event-harness')
    end

    scenario 'and is confirmed' do
      @reservation = create :reservation, :confirmed, user: @user2, equipment: @equipment

      visit lab_lab_space_equipment_path(@lab, @lab_space, @equipment)
      find('.fc-timegrid-event-harness').click

      expect(page).to have_selector('#cancelBtn', visible: false)
      expect(page).to have_selector('#rejectBtn', visible: false)
      expect(page).to have_selector('#acceptBtn', visible: false)

      expect(find('#detailUserField')).to have_text(@user2.name)
      expect(find('#detailStatusField')).to have_text('Confirmada')
      expect(find('#detailPurposeField')).to have_text('Academic')
      expect(find('#detailCommentField')).to have_text(@reservation.comment)
      expect(find('#detailDateField')).to have_text(readable_date_range(@reservation.start_time, @reservation.end_time))
    end

    scenario 'and is rejected' do
      create :reservation, :rejected, user: @user2, equipment: @equipment
      visit lab_lab_space_equipment_path(@lab, @lab_space, @equipment)

      expect(page).not_to have_selector('.fc-timegrid-event-harness')
    end

    scenario 'and is cancelled' do
      create :reservation, :cancelled, user: @user2, equipment: @equipment
      visit lab_lab_space_equipment_path(@lab, @lab_space, @equipment)

      expect(page).not_to have_selector('.fc-timegrid-event-harness')
    end
  end
end
