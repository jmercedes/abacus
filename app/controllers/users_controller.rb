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
    @user.assign_attributes(user_params)
    respond_to do |format|
      if @user.save
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
      @user.build_profile unless @user.profile
    end

    def user_params
      params.require(:user).permit(
        :email,
        profile_attributes: [
          :names,
          :lastnames,
          :personal_identification_number,
          :nationality,
          :social_status,
          :gender,
          :"date_of_birth(3i)",
          :"date_of_birth(2i)",
          :"date_of_birth(1i)",
          :country,
          :residence_status,
          :time_living_in_current_residence,
          :residence_phone_number,
          :mobile_phone_number,
          :office_phone_number,
          :address,
          :address_2,
          :address_reference,
          :city,
          :sector,
          :province,
          :prior_job,
          :currently_working,
          :scholar_degree,
          :profession,
          :job_status,
          :job_position,
          :business_name,
          :business_social_reason,
          :business_phone,
          :time_in_current_job,
          :monthly_income,
          :other_income,
          :spouse_names,
          :spouse_lastnames,
          :spouse_personal_identification_number,
          :spouse_mobile_phone_number,
          :"spouse_birthdate(3i)",
          :"spouse_birthdate(2i)",
          :"spouse_birthdate(1i)",
          :spouse_job_place,
          :spouse_job_position,
          :spouse_monthly_salary,
          :father_names,
          :father_lastnames,
          :father_residence_phone_number,
          :father_mobile_phone_number,
          :father_personal_identification_number,
          :"father_birthdate(3i)",
          :"father_birthdate(2i)",
          :"father_birthdate(1i)",
          :father_address,
          :father_address_2,
          :father_country,
          :father_city,
          :father_sector,
          :father_province,
          :mother_names,
          :mother_lastnames,
          :mother_residence_phone_number,
          :mother_mobile_phone_number,
          :"mother_birthdate(3i)",
          :"mother_birthdate(2i)",
          :"mother_birthdate(1i)",
          :mother_address,
          :mother_address_2,
          :mother_country,
          :mother_city,
          :mother_sector,
          :mother_province,
          assets_attributes: [
            :name,
            :description,
            :commercial_value,
            :ownership_status,
            :amount_owned,
            :amount_debt
          ],
          references_attributes: [
            :name,
            :last_name,
            :personal_identification_number,
            :residence_phone_number,
            :mobile_phone_number,
            :linkage
          ],
          guarantor_attributes: [
            :first_name,
            :second_name,
            :personal_identification_number,
            :"birth_date(3i)",
            :"birth_date(2i)",
            :"birth_date(1i)",
            :gender,
            :nationality,
            :residence_phone_number,
            :mobile_phone_number,
            :address,
            :city,
            :province,
            :zipcode
          ]
        ]
      )
    end

    def check_if_editable!
      redirect_to @user, notice: 'Unable to edit completed account' unless @user.profile.editable?
    end
end
