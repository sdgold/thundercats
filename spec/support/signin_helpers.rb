module SigninHelpers
  # def current_user(admin_user = false, super_admin_user = false)
  #   return @current_user if @current_user

  #   # if admin_user && super_admin_user
  #   #   @current_user = build_stubbed(:user, is_admin: true, type: "SuperAdminUser")
  #   # elsif admin_user
  #   #   @current_user = build_stubbed(:user, is_admin: true)
  #   # else
  #     # @current_user = create(:user)
  #   # end
  # end

  def current_user
    if @current_user
      return @current_user
    else
      return nil
    end

    # if admin_user && super_admin_user
    #   @current_user = build_stubbed(:user, is_admin: true, type: "SuperAdminUser")
    # elsif admin_user
    #   @current_user = build_stubbed(:user, is_admin: true)
    # else
      # @current_user = create(:user)
    # end
  end

  # def user_session
    # mock_user_session = double("UserSession", { user: current_user })
    # @current_user_session ||= mock_user_session
  # end

  # def admin_user_session
  #   mock_user_session = double("UserSession", { user: current_user(admin_user: true) })
  #   @current_user_session ||= mock_user_session
  # end

  # def super_admin_user_session
  #   mock_user_session = double("UserSession", { user: current_user(admin_user: true, super_admin_user: true) })
  #   @current_user_session ||= mock_user_session
  # end

  def login
    @current_user = build_stubbed(:user)

    @current_user_session = double("UserSession", { user: @current_user })
    allow(UserSession).to receive(:find).and_return(@current_user_session)
  end

  # def admin_login
  #   allow(UserSession).to receive(:find).and_return(admin_user_session)
  # end

  # def super_admin_login
  #   allow(UserSession).to receive(:find).and_return(super_admin_user_session)
  # end

  def logout
    current_user = nil
    current_user_session = nil
    @current_user = nil
    @current_user_session = nil
    @user_session = nil
  end
end

RSpec.configure do |config|
  config.include SigninHelpers
end