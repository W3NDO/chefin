require 'rails_helper'

RSpec.describe "Ingredients", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/ingredients/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/ingredients/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/ingredients/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/ingredients/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
