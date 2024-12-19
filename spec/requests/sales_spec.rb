require 'rails_helper'

RSpec.describe "Sales", type: :request do
  describe "GET /sales" do
    it "returns http success" do
      get "/sales"
      expect(response).to have_http_status(:success)
    end
  end

end
