module CollectionsHelper

	def collection_owner
		@collection = Collection.find(params[:id])
		redirect_to(root_path) unless current_user?(@collection.user)
	end
end
