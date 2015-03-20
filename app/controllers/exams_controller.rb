class ExamsController < ApplicationController
  # GET /exams
  # GET /exams.xml
  
  before_filter :login_required
  
  def status
    @subjects = SubjectLesson.current current_user.id
    @exam = Exam.find_by_id params[:id]
    status = params[:status]
    
    if status == "done"
      @exam.length_done = @exam.length
    else
      @exam.length_done = 0;
    end
    
    @exam.save
    
    respond_to do |wants|
      wants.html { redirect_to exams_path }
      wants.js { render :layout => false }
    end
  end
  
  def index
    # @exams = Exam.find(:all, :conditions => ["exams.when >= ?", Date.today])
    exams = current_user.active_exams
    @days = {}
    exams.each do |exam|
      @days[exam.when] ||= []
      @days[exam.when] << exam
    end
    @days = @days.sort

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => exams }
    end
  end

  # GET /exams/1
  # GET /exams/1.xml
  def show
    @exam = Exam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exam }
    end
  end

  # GET /exams/new
  # GET /exams/new.xml
  def new
    @exam = Exam.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exam }
      format.js { render :layout => false }
    end
  end

  # GET /exams/1/edit
  def edit
    @exam = Exam.find(params[:id])
  end

  # POST /exams
  # POST /exams.xml
  def create
    @exam = Exam.new(params[:exam])

    respond_to do |format|
      if @exam.save
        format.html { flash[:notice] = 'Písomka bola uložená.|Deň pred termínom sa ti objaví na nástenke.'; redirect_to(params[:redirect] ? {:controller => params[:redirect]} : exams_path) }
        format.xml  { render :xml => @exam, :status => :created, :location => @exam }
        format.js   { render :layout => false }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
        format.js   { render :layout => false }
      end
    end
  end

  # PUT /exams/1
  # PUT /exams/1.xml
  def update
    @exam = Exam.find(params[:id])

    respond_to do |format|
      if @exam.update_attributes(params[:exam])
        flash[:notice] = 'Zmeny sa uložili'
        format.html { redirect_to(exams_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exam.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /exams/1
  # DELETE /exams/1.xml
  def destroy
    @exam = Exam.find(params[:id])
    @exam.destroy

    respond_to do |format|
      format.html { redirect_to(exams_url) }
      format.xml  { head :ok }
      format.js   { render :layout => false }
    end
  end
end
