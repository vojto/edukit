class HomeworksController < ApplicationController
  # GET /homeworks
  # GET /homeworks.xml
  
  before_filter :login_required
    
  def status
    @subjects = SubjectLesson.current current_user.id
    @homework = Homework.find_by_id params[:id]
    status = params[:status]
    
    if status == "done"
      @homework.length_done = @homework.length
    else
      @homework.length_done = 0;
    end
    
    @homework.save
    
    respond_to do |wants|
      wants.html { redirect_to homeworks_path }
      wants.js { render :layout => false }
    end
  end
  
  def index
    # @homeworks = Homework.find(:all, :conditions => ["homeworks.when >= ?", Date.today])
    homeworks = current_user.active_homeworks
    @days = {}
    homeworks.each do |homework|
      @days[homework.when] ||= []
      @days[homework.when] << homework
    end
    @days = @days.sort

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => homeworks }
    end
  end

  # GET /homeworks/1
  # GET /homeworks/1.xml
  def show
    @homework = Homework.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @homework }
    end
  end

  # GET /homeworks/new
  # GET /homeworks/new.xml
  def new
    @homework = Homework.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @homework }
      format.js { render :layout => false }
    end
  end

  # GET /homeworks/1/edit
  def edit
    @homework = Homework.find(params[:id])
  end

  # POST /homeworks
  # POST /homeworks.xml
  def create
    @homework = Homework.new(params[:homework])

    respond_to do |format|
      if @homework.save
        format.html { flash[:notice] = 'Domáca úloha bola uložená.|Deň pred termínom sa ti objaví na nástenke.'; redirect_to(params[:redirect] ? {:controller => params[:redirect]} : homeworks_path) }
        format.xml  { render :xml => @homework, :status => :created, :location => @homework }
        format.js   { render :layout => false }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @homework.errors, :status => :unprocessable_entity }
        format.js   { render :layout => false }
      end
    end
  end

  # PUT /homeworks/1
  # PUT /homeworks/1.xml
  def update
    @homework = Homework.find(params[:id])

    respond_to do |format|
      if @homework.update_attributes(params[:homework])
        flash[:notice] = 'Zmeny sa uložili'
        format.html { redirect_to(homeworks_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @homework.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /homeworks/1
  # DELETE /homeworks/1.xml
  def destroy
    @homework = Homework.find(params[:id])
    @homework.destroy

    respond_to do |format|
      format.html { redirect_to(homeworks_url) }
      format.xml  { head :ok }
      format.js   { render :layout => false }
    end
  end
end
