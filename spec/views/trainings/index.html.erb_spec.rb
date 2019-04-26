require 'rails_helper'

RSpec.describe "trainings/index", type: :view do
  before(:each) do
    assign(:trainings, [
      Training.create!(
        :name => "Name",
        :description => "MyText",
        :equipment => nil
      ),
      Training.create!(
        :name => "Name",
        :description => "MyText",
        :equipment => nil
      )
    ])
  end

  it "renders a list of trainings" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
