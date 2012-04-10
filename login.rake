namespace :install do  
 desc "Load all the files from login plugin"  
 task :login do  
   system "rsync -ruv vendor/plugins/login/app/models app" 
   system "rsync -ruv vendor/plugins/login/app/controllers app"
   system "rsync -ruv vendor/plugins/login/app/views app"  
   system "rsync -ruv vendor/plugins/login/config/s3.yml config" 
   system "rsync -ruv vendor/plugins/login/config/routes.rb config" 
   system "rsync -ruv vendor/plugins/login/config/load_configs.rb config" 
   system "rsync -ruv vendor/plugins/login/config/rabl_init.rb config/initializers"
   system "rsync -ruv vendor/plugins/login/db/migrate db"
   system "rsync -ruv vendor/plugins/login/javascripts public"
   system "rsync -ruv vendor/plugins/login/stylesheets public"
   system "rsync -ruv vendor/plugins/login/Gemfile Gemfile"
 end  
end
