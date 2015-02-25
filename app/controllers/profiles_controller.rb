class ProfilesController < ApplicationController

  #before_action :authenticate_user!

  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  
  
  
  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
    
    @profile.build_guarantor
    2.times { @profile.assets.build }
    2.times { @profile.references.build }
  end
  
  def create
    @profile = Loan.new(profile_params)
    
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Loan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private

    def set_profile
      @profile = Profile.find(params[:id])
    end

    def set_params
      params.require(:profile).permit(:first_name)
    end


end

