
class AttachmentsController < ApplicationController
	before_filter :authorized_user
  	respond_to :json, :xml
  #Creates the Attachment for the User
  def create
    a=JSON.parse(params.to_json)
    Attachment.create_file(params[:encoded],@current_user)
    respond_to do |format|
        format.json { render :json => success }
        format.xml { render :xml => success }
    end
  end
end

