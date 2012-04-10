
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :trackable, :confirmable, :token_authenticatable
  # Setup accessible (or protected) attributes for your model
    attr_accessor :step
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name,:last_name,:birth_date, :home_phone, :mobile_phone, :street, :city, :state, :zip, :country,:step
  
  has_many :profiles, :class_name => "Profile", :foreign_key=>'owner_id'

  has_one :contact_detail,:as => :attachable
  
  
  has_one :attachment, :as => :attachable,:dependent => :destroy
  
  
 #validations for email and password
  validates :email, :presence => {:message => "Please enter a valid email address"}, :if => Proc.new { |at| at.step!="1" }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i , :message => "Please enter a valid email address"
  validates_uniqueness_of :email, :message => "Email Address Already Exists"
  validates :password, :presence => {:message => "Please enter a password (6 - 32 characters)"},:length=>{:in=>6..32,:message => "Please enter enter a password (6 - 32 characters)"}, :if => Proc.new { |at| at.step!="1" }
  validates :password_confirmation, :presence => {:message => "Sorry, that password doesn't match. Please try again."},:if => Proc.new { |at| at.step!="1" }
  validates_confirmation_of :password, :message=>"Sorry, that password doesn't match. Please try again."
  
  #validations for first name, last name and birthdate
  validates :first_name, :presence => {:message => "Please enter first name (2-40 characters)"}
	validates :first_name,:length=>{:in=>2..40,:message => "Please enter first name (2-40 characters)"},:if => Proc.new { |at| !at.first_name.blank? }
	validates :first_name,:format=>{:with =>/^[a-zA-Z\s\-']+$/,:message => "First name can only contain letters, apostrophe or hyphen."},:if => Proc.new { |at| !at.first_name.blank? }
  validates :last_name, :presence => {:message => "Please enter last name (2-40 characters)"}
	validates :last_name,:length=>{:in=>2..40,:message => "Please enter last name (2-40 characters)"},:if => Proc.new { |at| !at.last_name.blank? }
	validates :last_name,:format=>{:with =>/^[a-zA-Z\s\-']+$/,:message => "Last name can only contain letters, apostrophe or hyphen."},:if => Proc.new { |at| !at.last_name.blank? }
  validates :birth_date, :presence=> {:message=> "Please select a birth date"}
  
  
  #validations for home phone and mobile phone
  validates :home_phone, :presence=>{:message=>"Please enter home phone number (up to 15 digits)"}, :if => Proc.new { |at| at.step!="2"} 
	validates :home_phone, :length=>{:minimum=>8, :message=>"Phone number too short! Must be at least 8 digits"}, :if => Proc.new { |at| at.step!="2"}
  #validates :home_phone, :length=>{:maximum=>15, :message=>"Phone number too long! Should not exceed 15 digits"}, :if => Proc.new { |at| at.step!="2"}
  validates :home_phone, :format => { :with => /^[[0-9]\+]+$/, :message => "Phone number can only contain numbers and '+'" }, :if => Proc.new { |at| at.step!="2" }
  validates :mobile_phone, :length=>{:minimum=>8, :message=>"Mobile number too short! Must be at least 8 digits"}, :if => Proc.new { |at| at.step!="2"}, :allow_blank=>true
  #validates :mobile_phone, :length=>{:maximum=>15, :message=>"Mobile number too long! Should not exceed 15 digits"}
  validates :mobile_phone, :format => { :with => /^[[0-9]\+]+$/, :message => "Mobile number can only contain numbers and '+'" }, :if => Proc.new { |at| at.step!="2" }, :allow_blank=>true
  
  #validations for street, city, state, pincode and country
  validates :street, :presence=>{:message=>"Please enter street and number"}, :length=>{:minimum=>2, :message=>"Street too short! Must be at least 2 characters"}, :if => Proc.new { |at| at.step!="2" }
  validates :street, :format=>{:with=>/^[0-9a-zA-Z\s\, ]+$/, :message=>"Street name must have some letters!"}, :if => Proc.new { |at| at.step!="2" }
  validates :city, :presence=>{:message=>"Please enter city"}, :length=>{:minimum=>2, :message=>"City too short! Must be at least 2 characters"}, :if => Proc.new { |at| at.step!="2" }
  validates :city, :format=>{:with=>/^[a-zA-Z\s]+$/, :message=>"City name must have some letters!"}, :if => Proc.new { |at| at.step!="2" }
  validates :state, :presence=>{:message=>"Please enter state"}, :length=>{:minimum=>2, :message=>"State too short! Must be at least 2 characters"}, :if => Proc.new { |at| at.step!="2" }
  validates :state, :format=>{:with=>/^[a-zA-Z\s]+$/, :message=>"State name must have some letters!"}, :if => Proc.new { |at| at.step!="2" }
  validates :zip, :presence=>{:message=>"Please enter zip/postal code"}, :length=>{:minimum=>2, :message=>"Zip/postal code too short! Must be at least 2 numbers"}, :if => Proc.new { |at|   at.step!="2" }
 validates :zip, :format=>{:with=>/^[0-9\s]+$/, :message=>"Zip/postal code must be numbers"}, :if => Proc.new { |at| at.step!="2" }
 validates :country, :presence=>{:message=>"Please select your country"}, :if => Proc.new { |at| at.step!="2" }, :if => Proc.new { |at| at.step!="2" }
  
  
  def updatePassword(params)
    self.update_attributes(:password=>params[:new_password], :password_confirmation=>params[:confirm_password],:step=>"2")
  end
  
  def before_update_account(params)
    unless params[:first_name]
     self.first_name="temporary" if self.first_name.nil?
   end
    unless params[:last_name]
     self.last_name="temporary" if self.last_name.nil?
   end
    unless params[:mobile_phone]
     self.mobile_phone="11111111" if self.mobile_phone.nil?
   end
   unless params[:home_phone]
     self.home_phone="11111111" if self.home_phone.nil?
   end
   unless params[:street]
     self.street="temporary" if self.street.nil?
   end
   unless params[:city]
     self.city="temporary" if self.city.nil?
   end
   unless params[:state]
     self.state="temporary" if self.state.nil?
    end
    unless params[:zip]
     self.zip="11111" if self.zip.nil?
   end
    unless params[:country]
     self.country="temporary" if self.country.nil?
   end
  end
  
end


