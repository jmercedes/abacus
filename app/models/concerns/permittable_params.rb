module PermittableParams

  ProfileAttributes = [
    :names,
    :lastnames,
    :personal_identification_number,
    :nationality,
    :social_status,
    :gender,
    :date_of_birth,
    :profession,
    :scholar_degree,
    :residence_phone_number,
    :mobile_phone_number,
    :office_phone_number,
    :residence_status,
    :time_living_in_current_residence,
    :address,
    :address_2,
    :address_reference,
    :city,
    :sector,
    :province,
    :country,
    :job_status,
    :currently_working,
    :business_name,
    :business_social_reason,
    :business_phone,
    :job_position,
    :time_in_current_job,
    :monthly_income,
    :prior_job,
    :other_income,
    :father_names,
    :father_lastnames,
    :father_personal_identification_number,
    :father_residence_phone_number,
    :father_mobile_phone_number,
    :father_birthdate,
    :father_address,
    :father_address_2,
    :father_city,
    :father_sector,
    :father_province,
    :father_country,
    :mother_names,
    :mother_lastnames,
    :mother_residence_phone_number,
    :mother_mobile_phone_number,
    :mother_birthdate,
    :mother_address,
    :mother_address_2,
    :mother_city,
    :mother_sector,
    :mother_province,
    :mother_country,
    :spouse_names,
    :spouse_lastnames,
    :spouse_personal_identification_number,
    :spouse_mobile_phone_number,
    :spouse_birthdate,
    :spouse_job_place,
    :spouse_job_position,
    :spouse_monthly_salary
  ]  

  GuarantorAttributes = [
    :first_name,
    :second_name,
    :first_last_name,
    :second_last_name,
    :second_name,
    :personal_identification_number,
    :birth_date,
    :gender,
    :nationality,
    :residence_phone_number,
    :mobile_phone_number,
    :address,
    :city,
    :province,
    :zipcode
  ]

  AssetsAttributes = [
    :name, 
    :description,
    :commercial_value, 
    :ownership_status,
    :amount_owned, 
    :amount_debt,
    :_destroy
  ]

  RefrencesAttributes = [
    :name,
    :last_name,
    :personal_identification_number,
    :residence_phone_number,
    :mobile_phone_number,
    :linkage,
    :_destroy
  ]  

  UserPermittedParams = [
    :email, 
    :password, 
    :password_confirmation,
    profile_attributes: [
      ProfileAttributes + [:guarantor_attributes => GuarantorAttributes, :assets_attributes => AssetsAttributes,:references_attributes => RefrencesAttributes]  
      
    ]
  ]

  
end