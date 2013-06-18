class WorksController < ApplicationController
  
  def new
    @collection = Collection.find(params[:collection_id])
    @work = @collection.works.build
  end

  def create
    @collection = Collection.find(params[:collection_id])
    @work = @collection.works.build(params[:work])
    if @work.save
      flash[:success] = "Work added."
      redirect_to @collection
    else
      render :new
    end
  end

  def show
    @collection = Collection.find(params[:collection_id])
    @work = @collection.works.find(params[:id])
  end

  def edit
    @collection = Collection.find(params[:collection_id])
    @work = Work.find(params[:id])
  end

  def update
    @collection = Collection.find(params[:collection_id])
    @work = Work.find(params[:id])
    if @work.update_attribute(:title, params[:title]) && @work.update_attribute(:link, params[:link]) 
      flash[:success] = "Work updated."
      redirect_to @collection
    else
      render :edit
    end
  end 

  # @topic = Topic.find(params[:topic_id])
  #   @post = @topic.posts.find(params[:id])
  #   @post.update_attribute(:content, params[:content])
  #   flash[:success] = "Post updated."
  #   redirect_to edit_topic_post_url(@topic, @post)

  def destroy
    @work = Work.find(params[:id]) 
    @collection = @work.collection
    @work.destroy
    flash[:success] = "Work destroyed."
    redirect_to @collection
  end
end