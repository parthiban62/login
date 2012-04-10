module Login
class ConfirmationsController < Devise::ConfirmationsController

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    if User.where(:confirmation_token=>params[:confirmation_token]).first
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      resource.update_attribute(:authentication_token,SecureRandom.hex(10))
      render :json=>{"response"=>"success","access_token"=>resource.authentication_token}
    else
      render :json=>{:header=>{:status=>400}, :errors=>{:confirmation_token=>"Confirmation token is invalid"}}
    end
  end
end
end
