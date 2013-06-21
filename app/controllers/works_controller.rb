class WorksController < ApplicationController
  before_filter :signed_in_user
  before_filter :collection_work_owner, only: [:new, :create]
  before_filter :work_owner, only: [:edit, :update, :destroy]
  
  def new
    @collection = Collection.find(params[:collection_id])
    @work = @collection.works.build
  end

  def create
    @collection = Collection.find(params[:collection_id])
    @work = @collection.works.build(params[:work])
    if @work.save
      @work.create_activity :create, owner: current_user
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

  def destroy
    @work = Work.find(params[:id]) 
    @collection = @work.collection
    @work.destroy
    flash[:success] = "Work destroyed."
    redirect_to @collection
  end
end