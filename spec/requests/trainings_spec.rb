require 'rails_helper'

RSpec.describe "Trainings", type: :request do
  describe "GET /trainings" do
    it "works! (now write some real specs)" do
      get trainings_path
      expect(response).to have_http_status(200)
    end
  end
end
