require 'rails_helper'

RSpec.describe "Admin::Requests", type: :request do
  describe "GET /admin_requests" do
    it "works! (now write some real specs)" do
      get admin_requests_path
      expect(response).to have_http_status(200)
    end
  end
end
