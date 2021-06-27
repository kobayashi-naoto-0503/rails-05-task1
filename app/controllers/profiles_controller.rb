class ProfilesController < ApplicationController
  
  def new
    @profile = Profile.new
  end
  
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to user_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:photo, :hobby, :greeting).merge(user_id: current_user.id)
  end
  
end
