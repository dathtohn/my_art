class FriendshipsController < ApplicationController
	def create
		friend = User.find(params[:friend_id])
		if !friends?(friend)
		  @friendship = current_user.friendships.build(friend_id: params[:friend_id])
		  if @friendship.save
		    flash[:notice] = "Added friend."
		    redirect_to :back
		  else
		    flash[:error] = "Unable to add friend."
		    redirect_to :back
		  end
		else
			flash[:notice] = "Already supporting."
			redirect_to :back
		end
	end

	def destroy
	  @friendship = current_user.friendships.find_by_friend_id(params[:id])
	  @friendship.destroy
	  flash[:notice] = "Removed friendship."
	  redirect_to :back
	end
end