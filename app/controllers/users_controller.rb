class UsersController < ApplicationController
  before_filter :signed_in_user, except: [:new, :create]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    @collections = @user.collections
  end
  
  def new
    # make sure user is not signed in
    if !signed_in?
      @user = User.new
    else
      flash[:notice] = "Please sign out first."
      redirect_to root_path
    end
  end

  def create
    # make sure user is not signed in
    if !signed_in?
      @user = User.new(params[:user])
      if @user.save
        # Handle a successful save.
        sign_in @user
        flash[:success] = "Welcome to My Art"
        redirect_to @user
      else
        render 'new'
      end
    else
      flash[:notice] = "Please sign out first."
      redirect_to root_path
    end
  end

  def update
    if @user.update_attributes(params[:user])
      # Handle a successful update.
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def profile
    @user = User.find(params[:id])
  end

  # def updatepicture
  #   if @user.update_attribute(:picture, params[:picture])
  #     flash[:success] = "Updated profile picture."
  #   else
  #     render 'profile'
  #   end
  #   redirect_to profile_user_path(@user)
  # end

  # def updatedescription
  #   if current_user.update_attribute(:description, params[:description])
  #     flash[:success] = "Updated profile description."
  #   else
  #     render 'profile'
  #   end
  #   redirect_to profile_user_path(current_user)
  # end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    user = User.find(params[:id])
    if current_user != user
      user.destroy
      flash[:success] = "User destroyed."
      redirect_to users_url
    else
      flash[:error] = "Cannot delete yourself."
      redirect_to users_url
    end
  end
end

#   private

#     def signed_in_user
#       unless signed_in?
#         store_location
#         redirect_to signin_url, notice: "Please sign in."
#       end
#     end

#     def correct_user
#       @user = User.find(params[:id])
#       redirect_to(root_path) unless current_user?(@user)
#     end

#     def admin_user
#       redirect_to(root_path) unless current_user.admin?
#     end
# end
