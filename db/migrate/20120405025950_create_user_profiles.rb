class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :contact_details do |t|
t.integer :profile_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :home_phone
      t.string :mobile_phone
      t.string :street
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.date :birth_date
      t.timestamps
    end
  end
end
