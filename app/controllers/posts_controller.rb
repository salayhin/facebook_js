
class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index

    #client = Twitter::REST::Client.new do |config|
    #  config.consumer_key        = "0SA42a0JKM6PdD1q0PNCZg"
    #  config.consumer_secret     = "YV97lqlpZd7T1sNrkDMZOqN9Gnd1pvOxrzwgv9jQuo"
    #  config.access_token        = "106499488-wdXh967DnNt5e1zW26YBQYqSOCggCtu9SdivrAc8"
    #  config.access_token_secret = "diKltR3e8H8T9K7fCuZfGxenvgpWsvN5PwdhEyX7tQ"
    #end

    require "rubygems"

    # Certain methods require authentication. To get your Twitter OAuth credentials,
    # register an app at http://dev.twitter.com/apps
    Twitter.configure do |config|
      config.consumer_key        = "0SA42a0JKM6PdD1q0PNCZg"
      config.consumer_secret     = "YV97lqlpZd7T1sNrkDMZOqN9Gnd1pvOxrzwgv9jQuo"
      config.access_token        = "106499488-wdXh967DnNt5e1zW26YBQYqSOCggCtu9SdivrAc8"
      config.access_token_secret = "diKltR3e8H8T9K7fCuZfGxenvgpWsvN5PwdhEyX7tQ"
    end

    # Initialize your Twitter client
    client = Twitter::Client.new

    # Post a status update
    client.update("I just posted a status update via the Twitter Ruby Gem !")
    redirect_to request.referer, :notice => 'Tweet successfully posted'

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :title, :content)
    end
end
