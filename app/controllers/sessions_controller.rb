class SessionsController < ApplicationController
  before_action :forbid_login_user, {only: [:new]}
  #↑特定のViewをログイン時に表示させないようにするときbefore_actionで適応させるアクションをonlyで指定する。指定しないとコントローラー内全てに適応される。
  
  def new
  end

  def create
    user = User.find_by(email:session_params[:email])
    if user && user.authenticate(session_params[:password])
      log_in user
      redirect_to topics_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  
  def destroy
    log_out
    redirect_to root_url,info:'ログアウトしました'
  end

  private
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def session_params
    params.require(:session).permit(:email, :password)
  end
  
end
