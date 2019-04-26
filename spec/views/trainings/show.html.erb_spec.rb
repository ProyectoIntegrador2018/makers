require 'rails_helper'

RSpec.describe "trainings/show", type: :view do
  before(:each) do
    @training = assign(:training, Training.create!(
      :name => "Name",
      :description => "MyText",
      :equipment => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
