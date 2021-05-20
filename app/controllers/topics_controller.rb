class TopicsController < ApplicationController
  
  def index
    @topics = Topic.all.includes(:favorite_users)
  end
  
  def new
    @topic = Topic.new
  end
  
  def edit
    @topic = Topic.find(params[:id]) #edit.htmlにtopic.id（保存してある投稿データ）を渡している。
  end
  
  def update
    @topic = Topic.find(params[:id]) #編集したデータを受け取っている。
    @topic.update(topic_params) #受け取ったtopic_paramsのデータ（編集されたデータ）をDBに更新している。
    redirect_to topics_path #更新し終わったらtopicのindex.htmlへ
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
  
  def destroy
    Favorite.find_by(params[:topic_id]).destroy
    flash[:success]="お気に入りを削除しました"
    redirect_to topics_path
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
end
