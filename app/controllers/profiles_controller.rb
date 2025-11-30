class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [ :edit ]

  def edit
    @profile = current_user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to root_path, notice: 'プロフィールを更新しました'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def profile_params
    params.require(:profile).permit(:name, :image)
  end
end
