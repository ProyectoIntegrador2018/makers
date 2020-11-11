require 'spec_helper'

feature 'Pills', js: true do
  before do
    lab = create :lab
    lab_space = create :lab_space, lab: lab

    @equipment = create :equipment, lab_space: lab_space
    create :material, equipment: [@equipment], name: 'Material 1'
    create :capability, equipment: [@equipment], name: 'Capability 1'

    @equipment2 = create :equipment, lab_space: lab_space
    create :material, equipment: [@equipment2], name: 'Material 2'
    create :capability, equipment: [@equipment2], name: 'Capability 2'

    visit root_path
  end

  scenario 'selects a capability' do
    find('.pill', text: 'Capability 1').click

    expect(find('#capabilities')).to have_selector('.pill.blue', text: 'Capability 1')
    expect(find('.pillBox')).to have_selector('.pill.blue', count: 0)
    expect(find('.pillBox')).to have_selector('.pill.white', count: 1)
    expect(find('.pill.white')).to have_text('Material 1')
  end

  scenario 'selects a material' do
    find('.pill', text: 'Material 2').click

    expect(find('#materials')).to have_selector('.pill.white', text: 'Material 2')
    expect(find('.pillBox')).to have_selector('.pill.white', count: 0)
    expect(find('.pillBox')).to have_selector('.pill.blue', count: 1)
    expect(find('.pill.blue')).to have_text('Capability 2')
  end

  scenario 'selects a capability first and material second' do
    find('.pill', text: 'Capability 1').click
    expect(find('#capabilities')).to have_selector('.pill.blue', text: 'Capability 1')

    find('.pill', text: 'Material 1').click
    expect(find('#materials')).to have_selector('.pill.white', text: 'Material 1')

    expect(page).to have_selector('.pillBox', count: 0)
  end

  scenario 'selects a material first and capability second' do
    find('.pill', text: 'Material 2').click
    expect(find('#materials')).to have_selector('.pill.white', text: 'Material 2')

    find('.pill', text: 'Capability 2').click
    expect(find('#capabilities')).to have_selector('.pill.blue', text: 'Capability 2')

    expect(page).to have_selector('.pillBox', count: 0)
  end

  scenario 'filter capability with input' do
    fill_in 'capacidad', with: 'Capability 1'

    expect(find('.pillBox')).to have_selector('.pill.blue', count: 1)
    expect(find('.pill.blue')).to have_text('Capability 1')
  end

  scenario 'filter material with input' do
    fill_in 'material', with: 'Material 2'

    expect(find('.pillBox')).to have_selector('.pill.white', count: 1)
    expect(find('.pill.white')).to have_text('Material 2')
  end

  scenario 'submits query with pills' do
    find('.pill', text: 'Capability 1').click
    find('.pill', text: 'Material 1').click
    click_on 'Buscar'

    expect(current_path).to eq(equipment_index_path)
    expect(page).to have_selector('.SearchResult', count: 1)
    expect(page).to have_text(@equipment.name)
  end

  scenario 'submits query with pill and input' do
    find('.pill', text: 'Capability 1').click
    fill_in 'material', with: 'Material 1'
    click_on 'Buscar'

    expect(current_path).to eq(equipment_index_path)
    expect(page).to have_selector('.SearchResult', count: 1)
    expect(page).to have_text(@equipment.name)
  end

  scenario 'submits query unmatching input' do
    fill_in 'material', with: 'Blah blah blah'
    click_on 'Buscar'

    expect(current_path).to eq(equipment_index_path)
    expect(page).to have_selector('.SearchResult', count: 0)
  end
end
