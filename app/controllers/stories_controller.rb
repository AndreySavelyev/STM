class StoriesController < ApplicationController
  before_filter :login_required, :except => :index

  def index
    @stories = Story.all
  end
  
  def new
    @story = Story.new
    @users = User.active
  end
  
  def create
    @story = Story.new(params[:story])
    if  @story.save
      redirect_to stories_url, :notice => "Story successfully created"
    else
      @users = User.active
      render "new"
    end
  end
  
  def edit
    @story = Story.find(params[:id])
    @users = User.active
  end
  
  def update
    @story = Story.find(params[:id])
    @story.update_attributes(params[:story])
    if @story.save
      redirect_to stories_url, :notice => "Story successfully updated"
    else
      @users = User.active
      render 'edit'
    end
  end
  
  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to stories_url, :notice => "Story successfully deleted"
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  def start
    @story = Story.find(params[:id])
    @story.start!(current_user)
    redirect_to stories_url
  end
  
  def finish
    @story = Story.find(params[:id])
    @story.finish!
    redirect_to stories_url
  end
  
  def accept
    @story = Story.find(params[:id])
    @story.accept!
    redirect_to stories_url
  end
  
  def reject
    @story = Story.find(params[:id])
    @story.reject!
    redirect_to stories_url
  end

end
