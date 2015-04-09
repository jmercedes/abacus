class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :profile]
  before_action :check_if_editable!, only: [:edit, :update]

  def profile
    render :show
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:email)
    end

    def check_if_editable!
      redirect_to @user, notice: 'Unable to edit completed account' unless @user.profile.editable?
    end
end
