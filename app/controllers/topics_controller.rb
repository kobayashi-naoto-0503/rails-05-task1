class TopicsController < ApplicationController
  before_action :user_logged_in?
  
  def index
    @topics = Topic.all.includes(:favorite_users)
  end
  
  def new
    @topic = Topic.new
  end
  
  def edit
    @topic = Topic.find(params[:id]) #edit.htmlにtopic.id（保存してある投稿データ）を渡している。
    unless @topic.user == current_user #unlessでcurrent_user(ログインしている人)と@topic.user(トピックを投稿したひと。トピックのユーザー)でなければと書いてある。
      redirect_to topics_path
    end
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
