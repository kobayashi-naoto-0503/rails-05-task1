class CommentsController < ApplicationController
  before_action :user_logged_in?
  
  def new
    @topic = Topic.find_by(params[:topic_id]) #投稿画面に移行するときtopic_idは持ってこれないため、find_byでTopicモデルから探してインスタンス変数に入れて
    @comment = Comment.new
  end
  
  def create
     @comment = current_user.comments.new(comment_params) #@commentはcontent,user_id,topic_idを保存している
    if @comment.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end
  
   private
  def comment_params
    params.require(:comment).permit(:content, :topic_id, :user_id)
  end
  
end