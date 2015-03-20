class NotesController < ApplicationController
  # GET /notes
  # GET /notes.xml
  
  before_filter :login_required
  protect_from_forgery :except => [:destroy]
  
  def index
    @subjects = current_user.notes

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])
    @subject = @note.subject

    respond_to do |format|
      if @note.save
        format.html { 
          flash[:notice] = 'Známka sa vytvorila.|Pripísala sa k predmetu a prepočítal sa priemer.'
          redirect_to(notes_path) 
        }
        format.xml  { render :xml => @note, :status => :created, :location => @note }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        flash[:notice] = 'Známka sa upravila.|Pripísala sa k predmetu a prepočítal sa priemer.'
        format.html { redirect_to(notes_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { 
        flash[:notice] = 'Známka sa vymazala.|Škrtli sme ju a priemer sa prepočítal.'
        redirect_to(notes_url) 
      }
      format.xml  { head :ok }
      format.js
    end
  end
  
  # This will destroy all notes
  def reset
    current_user.notes.each do |subject, notes|
      notes.each do |note|
        note.destroy
      end
    end
    redirect_to notes_path
  end
end
