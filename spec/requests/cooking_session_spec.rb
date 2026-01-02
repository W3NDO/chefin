require 'rails_helper'

RSpec.describe "CookingSessions", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/cooking_session/show"
      expect(response).to have_http_status(:success)
    end
  end
end
