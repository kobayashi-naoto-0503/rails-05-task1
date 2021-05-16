class PagesController < ApplicationController
  skip_before_action :user_logged_in?
  skip_before_action :forbid_login_user
  def index
  end

  def help
  end
  
  def link
  end
end
