module FriendshipsHelper
	def friends?(user)
		current_user.friendships.where(friend_id: user).exists?
	end
end
