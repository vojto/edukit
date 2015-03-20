class SubjectsController < ApplicationController
  # GET /subjects
  # GET /subjects.xml
  
  before_filter :login_required
  protect_from_forgery :except => [:updateTimetable, :create]
  
  def index
    @subjects = Subject.find(:all, :conditions => ["user_id = ?", current_user.id])
    @lessons = current_user.subject_lessons_hash
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subjects }
    end
  end
  
  def updateTimetable
    # first find all subject_lesson associations
    @lessons = current_user.subject_lessons_hash
    
    params[:timetable].each do |key, value|
      key = key.sub("slot_", "")
      item = @lessons[key]
      if not value.empty?
        # the lessons has assigned a subject, thus we should either change the lesson or create a new one
        if item
          item.subject_id = value.sub("subject_", "")
          item.save
        else
          item = SubjectLesson.new
          item.day = key.split("_")[0]
          item.lesson = key.split("_")[1]
          item.subject_id = value.sub("subject_", "")
          item.save
        end
      else
        # there's no subject assigned to lesson, so we should remove the lesson
        if item
          item.destroy
        end
      end
    end
    
    respond_to do |format|
      format.js { render :layout => false }
      format.html { redirect_to :controller => "subjects", :action => "index" }
    end
  end
  
  def settings
    @subjects = current_user.subjects
    if request.post?
      params[:subject].each do |k, v|
        # raise @subjects.to_yaml
         subject = @subjects.detect {|subject| subject.id.to_s == k.to_s}
         subject.update_attributes(v) if subject
      end
      # redirect_to :action => settings, :method => 'get'
    end
  end

  # GET /subjects/1
  # GET /subjects/1.xml
  def show
    @subject = Subject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subject }
    end
  end

  # GET /subjects/new
  # GET /subjects/new.xml
  def new
    @subject = Subject.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subject }
    end
  end

  # GET /subjects/1/edit
  def edit
    @subject = Subject.find(params[:id])
  end

  # POST /subjects
  # POST /subjects.xml
  def create
    @subject = Subject.new(params[:subject])
    @subject.user_id = current_user.id

    respond_to do |format|
      if @subject.save
        format.html { 
          flash[:notice] = 'Predmet bol vytvorený.'
          redirect_to(:action => "index") 
        }
        format.xml  { render :xml => @subject, :status => :created, :location => @subject }
        format.js { render :layout => false }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
        format.js { render :layout => false }
      end
    end
  end

  # PUT /subjects/1
  # PUT /subjects/1.xml
  def update
    @subject = Subject.find(params[:id])

    respond_to do |format|
      if @subject.update_attributes(params[:subject])
        flash[:notice] = 'Subject was successfully updated.'
        format.html { redirect_to({:action => "index"}) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.xml
  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'subjects', :action => 'settings' }
      format.xml  { head :ok }
      format.js   { render :layout => false }
    end
  end
end
