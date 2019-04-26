require 'rails_helper'

RSpec.describe "trainings/edit", type: :view do
  before(:each) do
    @training = assign(:training, Training.create!(
      :name => "MyString",
      :description => "MyText",
      :equipment => nil
    ))
  end

  it "renders the edit training form" do
    render

    assert_select "form[action=?][method=?]", training_path(@training), "post" do

      assert_select "input[name=?]", "training[name]"

      assert_select "textarea[name=?]", "training[description]"

      assert_select "input[name=?]", "training[equipment_id]"
    end
  end
end
