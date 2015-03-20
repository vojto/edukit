# This controller handles the login/logout function of the site.  
class SessionController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem

  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:session][:login], params[:session][:password])
    if logged_in?
      if params[:session][:remember_me] == "1"
        current_user.remember_me unless current_user.remember_token?
        cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
      end
      redirect_back_or_default('/')
      flash[:notice] = "Bol si úspešne prihlásený|Vitaj späť! Pozri si nástenku, spravuj svoje domáce úlohy, písomky a známky."
    else
      flash.now[:error] = "Prihlásenie zlyhalo|Skontroluj si údaje a skús to ešte raz."
      render :action => 'new'
    end
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end
  
  def openid_login
    url = params[:openid_url]
    authenticate_with_open_id url, :required => [:nickname, :email] do |result, url, registration|
      if result.successful?
        unless registration['nickname'] && registration['email']
          flash[:error] = "Prihlásenie s OpenID zlyhalo.|Tvoje konto síce funguje, ale nemáš vyplnený svoj OpenID profil. Edukit vyžaduje aspoň prezývku (nickname) a e-mail."
          return redirect_to( new_session_path )
        end
        @user = User.find_or_initialize_by_openid_url url
        if @user.new_record?
          @user.login = User.create_login(registration["nickname"])
          @user.email = registration[:email]
          @user.save(false)
        end
        self.current_user = @user
        flash[:notice] = "Bol si úspešne prihlásený so svojím OpenID.|Cez tvoje OpenID bude odteraz dostupné toto konto."
        redirect_to :controller => "overview", :action => "index"
      else
        flash[:error] = "Prihlásenie s OpenID zlyhalo.|Tvoje konto sa nám nedarí sprístupniť. Skús nejaké iné konto."
        redirect_to :controller => "session", :action => "new"
      end
    end
  end
end
