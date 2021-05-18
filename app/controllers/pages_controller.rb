class PagesController < ApplicationController
  skip_before_action :user_logged_in?

  def index
  end

  def help
  end
  
  def link
  end
end
