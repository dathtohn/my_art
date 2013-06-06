module SessionsHelper

	def sign_in
    cookies.permanent[:remember_token] = 1
  end

  def signed_in?
    !cookies[:remember_token].nil?
  end

  def sign_out
    cookies.delete(:remember_token)
  end
end