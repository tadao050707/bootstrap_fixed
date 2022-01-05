class UsersController < ApplicationController
  # before_action :authenticate_user!, only: [:mypage]
  before_action :set_user, only: %i[ show mypage edit update ]

  def show
  end

  # def mypage
  #   #redirect_to user_path(current_user)
  # end

  def edit
  end

  def update
  end


  private

    def set_user
      @user = User.find(params[:id])
    end
end
