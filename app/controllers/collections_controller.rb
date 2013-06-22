class CollectionsController < ApplicationController
  before_filter :signed_in_user
  before_filter :collection_owner, only: [:edit, :update, :destroy]

  def new
    @collection = current_user.collections.build
  end

  def create
    @collection = current_user.collections.build(params[:collection])
    if @collection.save
      @collection.create_activity :create, owner: current_user
      flash[:success] = "New collection created."
      redirect_to current_user
    else
      render :new
    end
  end

  def show
    @collection = Collection.find(params[:id])
    @commentable = @collection
    @comments = @commentable.comments
    @comment = Comment.new
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
    @collections = current_user.collections.all
  end

  def destroy
    if Collection.find(params[:id]).destroy
      flash[:success] = "Collection destroyed."
      redirect_to collections_url
    else
      flash[:error] = "Could not destroy."
    end
  end

  private

    def image_check?(url)
      require 'uri'
      require 'net/http'

      Net::HTTP.start(url.host, url.port) do |http|
        response = http.head(url.path)
        case response
        when Net::HTTPSuccess, Net::HTTPRedirection
          case response.content_type
          when "image/png", "image/gif", "image/jpeg"
            return true
          else
            return false
          end
        else
          return false
        end
      end
    end
end
