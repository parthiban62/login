
class Attachment < ActiveRecord::Base
	belongs_to :attachable,:polymorphic=>true
  has_attached_file :image, 
                    :storage => :s3,
                    :s3_credentials => YAML.load_file("config/s3.yml"),
                    :path => ":attachment/:id/:style.:extension",
                    :bucket => 'caremonkey',
                    :styles => lambda{ |a| ['image/jpg','image/jpeg', 'image/gif', 'image/png', 'image/bmp'].include?( a.content_type ) ? { :user => "33x33", :carer => "37x37>",:subject => "53x52", :avatar => "121x119",:profile=>"115x115",:xlarge=>"180>x150"} : {}  }
                    
                    

 	def self.create_file(encoded,profile,file_name)
		File.open("#{Rails.root}/tmp/#{file_name}", 'wb') do|f|
      f.write(Base64.decode64("#{encoded}"))
    end
	  new_file=File.new("#{Rails.root}/tmp/#{file_name}")
	  profile.attachment=Attachment.create(:image=>new_file)
    File.delete(new_file)
	end
	
	def self.update_file(encoded,profile,file_name)
		File.open("#{Rails.root}/tmp/#{file_name}", 'wb') do|f|
      f.write(Base64.decode64("#{encoded}"))
    end
	  new_file=File.new("#{Rails.root}/tmp/#{file_name}")
		#~ file=profile.attachment
		#~ file.destroy if file
	  file=profile.attachment.update_attributes(:image=>new_file)
    File.delete(new_file)
	end
end

