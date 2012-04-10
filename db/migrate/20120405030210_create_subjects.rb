class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
     t.integer :owner_id
      t.integer :access_type
      t.timestamps
    end
  end
end
