object @my_account
  attributes :first_name, :last_name, :date_of_birth, :home_phone, :mobile_phone, :street, :city, :state, :zip, :country, :birth_date

  node :images do |u|
    u.attachment ? {:avatar=>u.attachment.image(:avatar).to_s, :user=>u.attachment.image(:user).to_s} : ""
  end