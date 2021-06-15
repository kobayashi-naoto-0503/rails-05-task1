class UsersController < ApplicationController
  def new
    @users = User.new
  end
  
  def show
    @user = User.find_by(id: params[:id])
    user = User.find(params[:id])
    @topic = user.topics.order(created_at: :desc)
  end
  #コメント投稿者の名前から、投稿者のマイページに行くように実装したとき、リンクをuser_path(comment.user_id)にしてurlはちゃんと投稿者のidを取得していたが、
  #@topic = current_user.topicsにしていたため、viewのeachが@topicで、ログイン者のページが表示される様になっていた。
  #user = User.find(params[:id])によって、各viewのリンクuser_path(id)を指定することによりそのidを取得し@topicに入れている。よって、userごとのページに行ける様になる。

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, success:'登録が完了しました'
    else
      flash.now[:danger] = "登録に失敗しました"
      render :new
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
