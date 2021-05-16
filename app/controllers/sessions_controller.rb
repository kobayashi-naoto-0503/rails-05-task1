class SessionsController < ApplicationController
  skip_before_action :user_logged_in? #app_contollerでかいたdef user_logged_in?をスキップして適応させていない。
  before_action :forbid_login_user
  
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
