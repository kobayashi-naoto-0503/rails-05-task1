class PagesController < ApplicationController
  skip_before_action :user_logged_in?
  before_action :forbid_login_user, {only: [:index]}

  def index
  end

  def help
  end
  
  def link
  end
  
end
