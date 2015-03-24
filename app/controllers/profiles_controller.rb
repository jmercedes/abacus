class ProfilesController < ApplicationController

  before_action :authenticate_user!

  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  
  
  
  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
    
    # @profile.build_guarantor
    2.times { @profile.assets.build }
    # 2.times { @profile.references.build }
  end
  
  def create
    @profile = Profile.new(profile_params)
    
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

    def profile_params
      params.require(:profile).permit(:names, :lastnames, :date_of_birth, :personal_identification_number,
      :nationality, :social_status, :gender, :residence_status, :time_living_in_current_residence,
      :residence_phone_number, :mobile_phone_number,
      :office_phone_number,
      :address,
      :address_2,
      :city,
      :sector,
      :province,
      :spouse_first_name,
      :spouse_second_name,
      :spouse_first_lastname,
      :spouse_second_lastname,
      :spouse_personal_identification_number,
      :spouse_mobile_phone_number,
      #:spouse_date_of_birth,
      :father_first_name,
      :father_second_name,
      :father_first_lastname,
      :father_second_lastname,
      :mother_first_name,
      :mother_second_name,
      :mother_first_lastname,
      :mother_second_lastname,
      :references,
      :lastname,
      :residence_phone_number,
      :mobile_phone_number,
      :linkage,
      :profession,
      :scholar_degree,
      :job_status,
      :job_position,
      :business_name,
      :business_social_reason,
      :business_phone,
      :time_in_current_job,
      :monthly_income,
      :other_income,
      :guarantor,
      :second_name,
      :first_last_name,
      :second_last_name,
      :personal_identification_number,
      :birth_date,
      :gender,
      :nationality,
      :residence_phone_number,
      :mobile_phone_number,
      :address,
      :city,
      :province,
      :zipcode,
      :assets,
      :description,
      :commercial_value,
      :ownership_status,
      :amount_owned,
      :amount_debt,
      :assets_attributes => [:profile_id, :name, :description,
                             :commercial_value, :ownership_status,
                             :amount_owned, :amount_debt])
    end
    
    


end

