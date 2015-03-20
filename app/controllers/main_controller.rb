class MainController < ApplicationController
  layout "welcome"
  
  def index
    redirect_to :controller => "overview", :action => "index" if logged_in?
    @user = User.new
  end
end
