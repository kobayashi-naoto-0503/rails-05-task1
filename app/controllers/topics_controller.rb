class TopicsController < ApplicationController
  before_action :user_logged_in?
  before_action :edit_restrict,{only:[:edit]}
  
  def index
    @topics = Topic.all.includes(:favorite_users)
    @topics = Topic.all.order(created_at: :desc) #新しい順に並べる。descは降順（逆から並べる。３、２、１、の順の様に）、created_atは作成日時。orderメソッドとは、データベースから取得してきた値を並び替えることができるメソッドです。
    
  end
  
  def new
    @topic = Topic.new
  end
  
  def edit
    
  end
  
  def update
    @topic = Topic.find(params[:id]) #編集したデータを受け取っている。
    @topic.update(topic_params) #受け取ったtopic_paramsのデータ（編集されたデータ）をDBに更新している。
    redirect_to topics_path #更新し終わったらtopicのindex.htmlへ
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path
  end

  def create
    @topic = current_user.topics.new(topic_params)
    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
end
