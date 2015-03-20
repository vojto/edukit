class OverviewController < ApplicationController
  
  before_filter :login_required
  
  include ApplicationHelper
  
  def index
    @subjects     = SubjectLesson.current current_user.id
    
    @homeworks = current_user.active_homeworks next_work_date
    @exams     = current_user.active_exams next_work_date
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @subjects }
    end
  end
  
  def setComplete
    @subject = current_user.subjects.find_by_id!(params[:id])
    raise ActiveRecord::RecordNotFound, "Can't find subject with id #{params[:id]}" unless @subject
    @subject.done!
    
    populate_subjects
    
    respond_to do |format|
      format.html { redirect_to :controller => "overview" }
      format.js { render :layout => false }
    end
  end
  
  def revertComplete
    @subject = current_user.subjects.find_by_id!(params[:id])
    @subject.revert!
    
    populate_subjects
    
    respond_to do |format|
      format.html { redirect_to :controller => "overview" }
      format.js { render :layout => false }
    end
  end
  
  private
  
  def populate_subjects
    @subjects = SubjectLesson.current current_user.id
  end
end
