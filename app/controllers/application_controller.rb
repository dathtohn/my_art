class ApplicationController < ActionController::Base
  protect_from_forgery
  include PublicActivity::StoreController
  include UsersHelper
  include SessionsHelper
  include FriendshipsHelper
  include CollectionsHelper
  include WorksHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end
