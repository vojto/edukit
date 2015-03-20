class SubjectLessonsController < ApplicationController
  # GET /subject_lessons
  # GET /subject_lessons.xml
  def index
    @subject_lessons = SubjectLesson.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subject_lessons }
    end
  end

  # GET /subject_lessons/1
  # GET /subject_lessons/1.xml
  def show
    @subject_lesson = SubjectLesson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subject_lesson }
    end
  end

  # GET /subject_lessons/new
  # GET /subject_lessons/new.xml
  def new
    @subject_lesson = SubjectLesson.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subject_lesson }
    end
  end

  # GET /subject_lessons/1/edit
  def edit
    @subject_lesson = SubjectLesson.find(params[:id])
  end

  # POST /subject_lessons
  # POST /subject_lessons.xml
  def create
    @subject_lesson = SubjectLesson.new(params[:subject_lesson])

    respond_to do |format|
      if @subject_lesson.save
        flash[:notice] = 'SubjectLesson was successfully created.'
        format.html { redirect_to(@subject_lesson) }
        format.xml  { render :xml => @subject_lesson, :status => :created, :location => @subject_lesson }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subject_lesson.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subject_lessons/1
  # PUT /subject_lessons/1.xml
  def update
    @subject_lesson = SubjectLesson.find(params[:id])

    respond_to do |format|
      if @subject_lesson.update_attributes(params[:subject_lesson])
        flash[:notice] = 'SubjectLesson was successfully updated.'
        format.html { redirect_to(@subject_lesson) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subject_lesson.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subject_lessons/1
  # DELETE /subject_lessons/1.xml
  def destroy
    @subject_lesson = SubjectLesson.find(params[:id])
    @subject_lesson.destroy

    respond_to do |format|
      format.html { redirect_to(subject_lessons_url) }
      format.xml  { head :ok }
    end
  end
end
