class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
       t.token_authenticatable
       t.string :first_name
       t.string :last_name
       t.string :home_phone
       t.string :mobile_phone
       t.string :street
       t.string :city
       t.string :state
       t.string :zip
       t.string :country
       t.date :birth_date
       t.boolean :role_type


      t.timestamps
    end

    add_index :users, :email,  :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
     add_index :users, :authentication_token, :unique => true
  end

end
