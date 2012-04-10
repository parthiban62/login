module Login
class ContactDetail < ActiveRecord::Base
has_one :attachment, :as => :attachable
	belongs_to :user
	belongs_to :profile
	belongs_to :attachable,:polymorphic=>true
	attr_accessible :profile_id, :mobile_phone, :home_phone, :street, :city, :zip, :country, :state,:first_name, :last_name, :email, :birth_date
	
	#validations for email, first name, last name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i , :message => "Please enter a valid email address", :allow_blank=>true, :on=>:create
	validates :first_name, :presence => {:message => "Please enter first name (2-40 characters)"}, :on=>:create
	validates :first_name,:format=>{:with =>/^[a-zA-Z\s\-']+$/,:message => "First name can only contain letters, apostrophe or hyphen."},:if => Proc.new { |at| !at.first_name.blank? }, :on=>:create
	validates :first_name,:length=>{:in=>2..40,:message => "Please enter first name (2-40 characters)"},:if => Proc.new { |at| !at.first_name.blank? }, :on=>:create
  validates :last_name, :presence => {:message => "Please enter last name (2-40 characters)"}, :on=>:create
	validates :last_name,:format=>{:with =>/^[a-zA-Z\s\-']+$/,:message => "Last name can only contain letters, apostrophe or hyphen."},:if => Proc.new { |at| !at.last_name.blank? }, :on=>:create
	validates :last_name,:length=>{:in=>2..40,:message => "Please enter last name (2-40 characters)"},:if => Proc.new { |at| !at.last_name.blank? }, :on=>:create
  validates :birth_date, :presence=> {:message=> "Please select a birth date"}
	#validations home phone and mobile phone
	validates :home_phone, :presence=>{:message=>"Please enter home phone number (up to 15 digits)"}, :on=>:update
  validates :home_phone, :format => { :with =>/^[[0-9]\+]+$/, :message => "Phone number can only contain numbers and '+'" }, :on=>:update
	validates :home_phone, :length=>{:minimum=>8, :message=>"Phone number too short! Must be at least 8 digits"}, :on=>:update
  #validates :home_phone, :length=>{:maximum=>15, :message=>"Phone number too long! Should not exceed 15 digits"}, :on=>:update
  #validates :mobile_phone, :length=>{:maximum=>15, :message=>"Mobile number too long! Should not exceed 15 digits"}, :on=>:update
  validates :mobile_phone, :format => { :with =>/^[[0-9]\+]+$/, :message => "Mobile number can only contain numbers and '+'" }, :allow_blank=>true, :on=>:update
	validates :mobile_phone, :length=>{:minimum=>8, :message=>"Mobile number too short! Must be at least 8 digits"}, :allow_blank=>true, :on=>:update
	
	#validations for street, city, state, pincode and country
  validates :street, :presence=>{:message=>"Please enter street and number"}, :length=>{:minimum=>2, :message=>"Street too short! Must be at least 2 characters"}, :on=>:update
  validates :street, :format=>{:with=>/^[0-9a-zA-Z\s\, ]+$/, :message=>"Street name must have some letters!"}, :on=>:update
  validates :city, :presence=>{:message=>"Please enter city"}, :length=>{:minimum=>2, :message=>"City too short! Must be at least 2 characters"}, :on=>:update
  validates :city, :format=>{:with=>/^[a-zA-Z\s]+$/, :message=>"City name must have some letters!"}, :on=>:update
  validates :state, :presence=>{:message=>"Please enter state"}, :length=>{:minimum=>2, :message=>"State too short! Must be at least 2 characters"}, :on=>:update
  validates :state, :format=>{:with=>/^[a-zA-Z\s]+$/, :message=>"State name must have some letters!"}, :on=>:update
  validates :zip, :presence=>{:message=>"Please enter zip/postal code"}, :length=>{:minimum=>2, :message=>"Zip/postal code too short! Must be at least 2 numbers"}, :on=>:update
  validates :zip, :format=>{:with=>/^[0-9\s]+$/, :message=>"Zip/postal code must be numbers"}, :on=>:update
 validates :country, :presence=>{:message=>"Please select your country"}, :on=>:update
	def completed_status
	  if (self.first_name.present? && self.last_name.present? && self.home_phone.present? && self.mobile_phone.present? && self.street.present? && self.city.present? && self.state.present? && self. zip.present? && self.country.present? && self.date_of_birth.present?)
      return true
		else
			return false
    end			
end
end
