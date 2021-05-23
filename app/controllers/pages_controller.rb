class PagesController < ApplicationController
  before_action :forbid_login_user, {only: [:index]}

  def index
  end

  def help
  end
  
  def link
  end
  
end
