class PostsController < ApplicationController
  # This Devise helper ensures a user is signed in.
  # It will redirect to the sign-in page if they are not.
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
     # Build the post associated with the currently logged-in user.
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path, notice: "Post was successfully created."
    else
      # If saving fails, render the 'new' template again with errors.
      # The status :unprocessable_entity is important for Turbo.
      render :new, status: :unprocessable_entity

  end
end

private

  # Use strong parameters to protect against mass assignment vulnerabilities.
  def post_params
    params.require(:post).permit(:title, :content)
  end
end