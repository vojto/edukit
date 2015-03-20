class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  before_filter :login_required, :only => :show

  # render new.rhtml
  def new
    @user = User.new
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.update_attributes(params[:user])
    if @user.save
      flash[:notice] = "Zmeny sa uložili"
      redirect_to edit_account_path
    else
      render :action => "edit"
    end
  end

  def create
    cookies.delete :auth_token
    # protects against session fixation attacks, wreaks havoc with 
    # request forgery protection.
    # uncomment at your own risk
    # reset_session
    @user = User.new(params[:user])
    @user.save
    if @user.errors.empty?
      self.current_user = @user
      flash[:notice] = "Tvoje konto bolo vytvorené!|Ešte ho bude treba aktivovať. Pre inštrukcie si pozri svoj e-mail. Teraz si môžeš vytvoriť rozvrh hodín."
      redirect_to :controller => "subjects", :action => "index"
    else
      render :action => 'new'
    end
  end

  def activate
    self.current_user = params[:activation_code].blank? ? false : User.find_by_activation_code(params[:activation_code])
    if logged_in? && !current_user.active?
      current_user.activate
      flash[:notice] = "Signup complete!"
    end
    redirect_back_or_default('/')
  end


end
