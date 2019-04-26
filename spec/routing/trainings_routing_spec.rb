require "rails_helper"

RSpec.describe TrainingsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/trainings").to route_to("trainings#index")
    end

    it "routes to #new" do
      expect(:get => "/trainings/new").to route_to("trainings#new")
    end

    it "routes to #show" do
      expect(:get => "/trainings/1").to route_to("trainings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/trainings/1/edit").to route_to("trainings#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/trainings").to route_to("trainings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/trainings/1").to route_to("trainings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/trainings/1").to route_to("trainings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/trainings/1").to route_to("trainings#destroy", :id => "1")
    end
  end
end
