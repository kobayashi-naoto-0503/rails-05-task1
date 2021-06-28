class UsersController < ApplicationController
  
  def new
    @users = User.new
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @topics = @user.topics.order(created_at: :desc)
    @profile = @user.profile
  end
  #params[:id]は画面上で取得したidを入れている。よって、@userはparamsで取得したidをfind_byでUserモデルから取ってきたデータが入っている。
  #@profileは@userのidを使ってprofileモデルのデータを取ってきたいので、modelsでアソシエーション組んであれば、@user.profileの書き方でOK
  #アソシエーションくんでなければ、find_by(user_id: @user.id)で探してあげないと取ってこれない。

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
