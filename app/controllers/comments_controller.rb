class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  
  def create
     @comment = current_user.comments.new(comment_params)
     @comment.topic_id=params[:topic_id]
    if @comment.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end
  
   private
  def comment_params
    params.require(:comment).permit(:content)
  end
  
end