# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '2f96804278d5b7fd896393647054b9a5'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  DefaultLayout = "main"
  layout :choose_layout
  
  rescue_from ActionController::RoutingError, :with => :error_404

  include AuthenticatedSystem
  
  def choose_layout
    request.env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest" ? false : DefaultLayout
  end
  
  def error_404
    render :template => "main/error_404", :with_layout => true
  end
  
  def rescue_action_in_public(exception)
    render :template => "main/error_500", :with_layout => true
  end
end
