module Login
class ApplicationController < ActionController::Base
  protect_from_forgery
    #protect_from_forgery
  
  #This is a filter to authenticate the user is authorized or not
  #~ def authenticate!
    #~ access_token=params[:header][:access_token]
    #~ @current_user=User.authorized_user? access_token if access_token
  #~ end
  
  #
  def cofirm!
    confirmation_token=params[:header][:confirmation_token]
    @current_user=User.confirm confirmation_token if confirmation_token
  end
  
  #Returns success if the process is success
  def success
    {:response=>:success}
  end
  
  #Returns success if the process is success
  def failure
    {:response=>:failure}
  end
  
  def failure1(error=nil)
    {:header=>{:status=>400}, :errors=>error}
  end
  
  def success1(body=nil)
    {:header=>{:status=>200}, :body=>body}
  end
  
  def authorized_user()
    logger.info("111111111111111111111111111111")
    logger.info(params)
    logger.info(params.has_key?(:header))
    if params.has_key?(:header)
      access_token=params[:header][:access_token]
    elsif
      access_token=params[:id]
    end
    @current_user=User.where(:authentication_token=>access_token).first unless access_token.nil?
    render :json=>{:header=>{:status=>400},:errors=>{:authentication_token=>{:code=>1005, :message=>"Authentication/Authorization Failed"}}} if @current_user.nil?
  end
  def authorize(access_token)
    @current_user=User.where(:authentication_token=>access_token).first unless access_token.nil?
    render :json=>{:header=>{:status=>400},:errors=>{:authentication_token=>{:code=>1005, :message=>"Authentication/Authorization Failed"}}} if @current_user.nil?
    return true;
  end
end
end
