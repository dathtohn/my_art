class ApplicationController < ActionController::Base
  protect_from_forgery
  include PublicActivity::StoreController
  include UsersHelper
  include SessionsHelper
  include FriendshipsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end
