# require 'rails_helper'
# require 'authlogic/test_case'

require 'rails_helper'
# require 'authlogic/test_case' # must be called, but can eliminate if already called
# include Authlogic::TestCase # must be called, but can eliminate if already called

RSpec.describe "Buildings", type: :request do
  # Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(self)
  setup :activate_authlogic
  # activate_authlogic

  describe "GET /index" do
    it "returns http success" do
      get "/buildings"
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "Test: regular user logged in >>" do
    it "#index should be accessible" do
      login

      get "/buildings"
      expect(response).to have_http_status(:success)
    end  
  end
end