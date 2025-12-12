require 'rails_helper'

RSpec.describe "Steps", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/steps/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/steps/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/steps/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/steps/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
