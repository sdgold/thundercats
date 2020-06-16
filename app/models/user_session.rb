class UserSession < Authlogic::Session::Base
  after_persisting :my_custom_logging

  private

  def my_custom_logging
    Rails.logger.info(
      format(
        'After authentication attempt, user id is %d',
        record.send(record.class.primary_key)
      )
    )
  end
end