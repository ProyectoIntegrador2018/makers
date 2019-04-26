require 'rails_helper'

RSpec.describe "trainings/new", type: :view do
  before(:each) do
    assign(:training, Training.new(
      :name => "MyString",
      :description => "MyText",
      :equipment => nil
    ))
  end

  it "renders new training form" do
    render

    assert_select "form[action=?][method=?]", trainings_path, "post" do

      assert_select "input[name=?]", "training[name]"

      assert_select "textarea[name=?]", "training[description]"

      assert_select "input[name=?]", "training[equipment_id]"
    end
  end
end
