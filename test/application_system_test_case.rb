require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
  
  include Warden::Test::Helpers

  def sign_in_as(user)
    login_as(user, scope: :user)
  end
end
