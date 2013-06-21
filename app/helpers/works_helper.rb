module WorksHelper

	def collection_work_owner
		@collection = Collection.find(params[:collection_id])
		redirect_to(root_path) unless current_user?(@collection.user)
	end

	def work_owner
		@collection = Work.find(params[:id]).collection
		redirect_to(root_path) unless current_user?(@collection.user)
	end
end
