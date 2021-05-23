class FavoritesController < ApplicationController
  before_action :user_logged_in?
  
  def index
    @favorite_topics=current_user.favorite_topics
  end
  
  def create
    favorite = Favorite.new
    favorite.user_id=current_user.id
    favorite.topic_id=params[:topic_id]
    if favorite.save
      redirect_to topics_path, success:'お気に入りに登録しました'
    else
      redirect_to topics_path, danger:'お気に入りに登録に失敗しました'
    end
  end
  def destroy
    Favorite.find_by(params[:topic_id]).destroy
    flash[:success]="お気に入りを削除しました"
    redirect_to topics_path
  end
end
