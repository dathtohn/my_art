class CommentsController < ApplicationController
  before_filter :load_commentable
  
  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      @comment.create_activity :create, owner: current_user
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end

  def destroy
  	if @commentable.comments.find(params[:id]).destroy
      flash[:success] = "Comment deleted."
      redirect_to @commentable
    else
      flash[:error] = "Could not destroy."
    end
  end

private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  # alternative option:
  # def load_commentable
  #   klass = [Article, Photo, Event].detect { |c| params["#{c.name.underscore}_id"] }
  #   @commentable = klass.find(params["#{klass.name.underscore}_id"])
  # end
end