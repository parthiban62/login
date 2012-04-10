module Login
class SessionsController < Devise::SessionsController
	 #~ prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  #~ prepend_before_filter :allow_params_authentication!, :only => :create
  #~ include Devise::Controllers::InternalHelpers

  # GET /resource/sign_in
  before_filter :authorized_user, :only=>[:destroy]
  def new
   #~ respond_to do |format|
     render :json =>{"response"=>"failure","error"=>flash[:alert]}
    #~ end
  end

  # POST /resource/sign_in
  def create
    user=params[:user]
    params[:user]={}
    params[:user][:email],params[:user][:password]=Base64.decode64(user).split(' ') #decodes the credentials as [email,password]
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    resource.update_attribute(:authentication_token,SecureRandom.hex(10))
    render :json=>find_user(resource)
  end

   def find_user(resource)
    {:user=>resource.serializable_hash(:only=>[:authentication_token,:email])}.merge({"response"=>"success"})
  end
  # DELETE /resource/sign_out
  def destroy
    resource=User.find_by_authentication_token(params[:header][:access_token])
    if resource.update_attribute(:authentication_token,nil)
      render :json=>{"response"=>"success"}
    else
      render :json=>resouce.errors
    end
    #~ signed_in = signed_in?(resource_name)
    #~ redirect_path = after_sign_out_path_for(resource_name)
    #~ Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    #~ set_flash_message :notice, :signed_out if signed_in

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    #~ respond_to do |format|
      #~ format.any(*navigational_formats) { redirect_to redirect_path }
      #~ format.all do
        #~ method = "to_#{request_format}"
        #~ text = {}.respond_to?(method) ? {}.send(method) : ""
        #~ render :text => text, :status => :ok
      #~ end
    #~ end
  end

  protected

  def stub_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { :methods => methods, :only => [:password] }
  end
end
end
