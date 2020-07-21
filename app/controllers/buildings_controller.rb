class BuildingsController < ApplicationController

  before_action :require_login

  def index
  end

  # protected

    # Filter to redirect to login screen if no user is logged in.
    def require_login
      unless current_user.present?
        flash[:success] = "Login Requied!"
        redirect_to login_path
        return false
      end
    end
end