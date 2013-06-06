class CollectionsController < ApplicationController
  
  def new
    @collection = Collection.new
  end

  def create
    @collection = Collection.new(params[:collection])
    if @collection.save
      flash[:success] = "New collection created."
      redirect_to collections_url
    else
      render :new
    end
  end

  def show
    @collection = Collection.find(params[:id])
    @works = @collection.works
  end

  def edit
    @collection = Collection.find(params[:id])
  end

  def update
    @collection = Collection.find(params[:id])
    if @collection.update_attributes(params[:collection])
      flash[:success] = "#{@collection.title} successfully updated."
      redirect_to collections_url
    else
      render :edit
    end
  end

  def index
    @collections = Collection.all
  end

  def destroy
    if Collection.find(params[:id]).destroy
      flash[:success] = "Collection destroyed."
      redirect_to collections_url
    else
      flash[:error] = "Could not destroy."
    end
  end
end
