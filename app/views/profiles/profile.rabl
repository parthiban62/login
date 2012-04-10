object @subject
attributes :id, :owner_id
glue :contact_detail do
  attributes :first_name, :last_name, :email, :home_phone, :mobile_phone, :street, :city, :state, :zip, :country, :birth_date
  node do |c|
    c.attachment ? {:url=>c.attachment.image(:profile).to_s} : ""
  end
end
child :emergency_contacts => :emergency_contacts do
  attributes :id,:profile_id, :first_name, :last_name, :email, :mobile_phone, :home_phone, :relationship, :first_emergency_contact
end

child :family_histories => :family_histories do
  attributes :id,:profile_id, :first_name, :condition_name, :description
end


child :operations => :operations do
  attributes :id,:profile_id, :first_name, :name, :operated_date, :description
end

child :emergency_information => :emergency_informations do
  attributes :id,:profile_id, :gender, :birth_date, :blood_group, :is_organ_donor, :organ_registration, :is_private_health, :private_health_insurance, :is_ambulance, :ambulance_registration
end

child :emergency_contacts => :emergency_contacts do
  attributes :id,:profile_id, :first_name, :last_name, :email, :mobile_phone, :home_phone, :relationship,:first_emergency_contact
end

child :immunisations => :immunisations do
attributes :id,:profile_id, :immunisation_date, :immunisation_name, :is_remembered
end

child :notes => :notes do
  attributes :id, :profile_id,:description,:is_private
end

child :safety_alerts => :safety_alerts do
  attributes :id,:profile_id, :alert_name, :risk, :has_medication, :medication_description, :symptoms, :is_approved_care_instructions
    node do |c|
      c.attachment ? {:url=>c.attachment.image.to_s, :file_name=>c.attachment.image_file_name} : " "
    end
end
