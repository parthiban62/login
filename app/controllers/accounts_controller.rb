
class AccountsController < ApplicationController
	#before_filter :authenticate!
	#before_filter :confirm!, :only=>[:confirm]
	before_filter :authorized_user,:except=>['update_sign_up2','find_name']
	respond_to :json, :xml
	#This show method displays the user's accout details
	def show
    @my_accounts=@current_user
	end
	
	#This update method is used to update the user's account details like firstname, lastname, email id, password, contact details etc.
	def update
		#@my_accounts=@current_user.user_profile.update_attributes(params[:body])
		@my_account=@current_user
		#@my_account.before_update_account(params[:body][:user])
    @my_account.update_attributes(params[:body][:user])
		#@my_accounts.after_update_account(params[:body][:user])
		file=params[:body][:file]
		unless file[:encoded].empty?
		  if @my_account.attachment.nil?
			  Attachment.create_file(file[:encoded],@my_account,file[:file_name])
			else
				Attachment.update_file(file[:encoded],@my_account,file[:file_name])
			end
		end
		unless @my_account.errors.empty?
		  render :json=>failure1(@my_account.errors)
		else
			render :json=>success1
		end
	end
	
	#This confirmation method saves user's accont details
	def confirm
	  @profiles=@current_user.user_profile.update_attributes(params[:body])
	end
	
	#UpdatePassword method updates the user's current password
	def update_password
		parameters=params[:body]
		  @my_accounts=@current_user
			if @my_accounts.valid_password?(parameters[:current_password])
			  if @my_accounts.updatePassword(parameters)
				   render :json=>success1
				else
				  render :json=>failure1(:current_password=>["Current password is wrong"])
			  end
		  else
		    render :json=>failure1(@my_accounts.errors)
		  end
	end
	
	def update_sign_up2
		 @my_account=User.find_by_authentication_token(params[:user][:access_token])
		 @my_account.update_attributes(:home_phone=>params[:user][:home_phone],:mobile_phone=>params[:user][:mobile_phone],:street=>params[:user][:street],:city=>params[:user][:city],:state=>params[:user][:state],:zip=>params[:user][:zip],:country=>params[:user][:country],:step=>'1')
		 if @my_account.errors.empty?
			 render :json=>success1
		else
			render :json=>failure1(@my_account.errors)
		end
	end
	
	def find_name
	  @user=User.find_by_reset_password_token(params[:id])
		render :json=>@user
	end
end

