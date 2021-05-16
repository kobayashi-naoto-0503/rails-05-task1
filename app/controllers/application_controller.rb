class ApplicationController < ActionController::Base
  before_action :user_logged_in?
  before_action :forbid_login_user
  
  protect_from_forgery with: :exception
  
  add_flash_types :success, :info, :warnig, :danger
  
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
  
  def user_logged_in? #認証情報の有無で、ログインしているかしていないかを分岐させる関数。
    if session[:user_id] #認証情報。「もし、session_contollerにlog_inメソッドで、session[:user_id]にログイン情報を保存しているなら。」
      begin #通常処理。begin~rescue~endはエラーが起きた時（今回はログイン情報がなかったら）実行が停止しないようにするメソッド
        @current_user = User.find_by(id: session[:user_id]) #session[:user_id]を@current_userに格納
      rescue ActiveRecord::RecordNotFound #エラー発生時の処理。ActiveRecord::RecordNotFoundが起こって止めない為の処理
        reset_user_session #セッション情報を消去している。
      end
    end
    return if @current_user #@current_userにログイン情報を保存していなければ、リダイレクトする。
      flash[:referer] = request.fullpath #リクエストurlを取得[よくわからないから質問する]
      redirect_to root_path 
  end
  
  def reset_user_session #リセットしたらsession[:user_id]と@current_userを空にする。
    session[:user_id] = nil
    @current_user = nil
  end
  
  def forbid_login_user #ログインしている時の制限。forbidは、禁止するという意味。
    if session[:user_id] #もし、session_contollerにlog_inメソッドで、session[:user_id]にログイン情報を保存しているのなら。
      flash[:notice]="ログイン中です"
      redirect_to topics_path #topicsへ行くようにする。コメント投稿のページにいくにはtopics_idがないからいけなかった、どうすればいい？
    end
  end
  
end