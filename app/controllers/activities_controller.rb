class ActivitiesController < ApplicationController
  def index
  	if signed_in?
	  	@activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.friend_ids, owner_type: "User")
	  else
	  	redirect_to home_path
	  end
  end
end
