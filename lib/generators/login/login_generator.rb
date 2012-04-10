require 'rails/generators'
require 'rails/generators/migration'

class LoginGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  Rake::Task['sync'].invoke
  def self.source_root
    #~ @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  #~ def self.next_migration_number(dirname)
    #~ if ActiveRecord::Base.timestamped_migrations
      #~ Time.new.utc.strftime("%Y%m%d%H%M%S")
    #~ else
      #~ "%.3d" % (current_migration_number(dirname) + 1)
    #~ end
  #~ end

  def create_migration_file
    #~ migration_template 'users.rb', 'db/migrate/create_users_table.rb',
		#~ migration_template 'profiles.rb', 'db/migrate/create_contact_details_table.rb',
		#~ migration_template 'subjects.rb', 'db/migrate/create_profiles_table.rb',
		#~ migration_template 'attachments.rb', 'db/migrate/create_attachments_table.rb'
  end
  
  def generate_model
        #~ invoke "active_record:model", [name], :migration => false unless model_exists? && behavior == :invoke
      end
end
