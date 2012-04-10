
class ProfilesController < ApplicationController
	before_filter :authorized_user
  def index
    @current_users=@current_user
    @subject = Profile.find_by_id_and_owner_id(params[:subject_id],@current_user.id)
    if @subject
      @emergency_contacts=@subject.emergency_contacts
      @family_histories=@subject.family_histories
      @operations=@subject.operations
      @immunisations=@subject.immunisations
      @safety_alerts=@subject.safety_alerts
      @notes=@subject.notes
      @emergency_informations=@subject.emergency_information
    else
      error={:record=>"Record not found"}
      render :json=>failure1(error)
    end
    
  end
  
  def show
    @subject = Profile.find_by_id_and_owner_id(params[:subject_id],@current_user.id)
    if @subject
      @emergency_contacts=@subject.emergency_contacts
      @family_histories=@subject.family_histories
      @operations=@subject.operations
      @immunisations=@subject.immunisations
      @safety_alerts=@subject.safety_alerts
      @notes=@subject.notes
      @emergency_informations=@subject.emergency_information
    else
      render :json=>failure
    end
    
  end
  
  def delete
    Profile.destroy(params[:id])
    render :json=>success
  end
  end

