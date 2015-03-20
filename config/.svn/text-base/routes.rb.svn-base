ActionController::Routing::Routes.draw do |map|
  map.resources :notes, :collection => { :reset => :delete }

  map.resources :exams, :member => { :status => [:post, :get], :destroy => :get }

  map.resources :homeworks, :member => { :status => [:post, :get], :destroy => :get }

  map.resources :users

  map.resource :session, :controller => 'session'
  map.login '/login', :controller => 'session', :action => 'new'
  map.signup '/registracia', :controller => 'users', :action => 'new'
  
  map.resources :users
  map.resource :account, :controller => "users"
  
  map.aktivacia "/aktivacia/:activation_code", :controller => 'users', :action => 'activate'
  map.odhlasenie "/odhlasit", :controller => "session", :action => "destroy"

  map.settings 'subjects/settings/*anything', :controller => 'subjects', :action => 'settings'

  map.resources :subject_lessons

  map.subject_destroy '/subjects/destroy/:id', :controller => "subjects", :action => "destroy"
  map.resources :subjects
  map.update_timetable '/subjects/updateTimetable', :controller => "subjects", :action => "updateTimetable"
    
  map.resources :overview, :member => { :setComplete => :get, :revertComplete => :get }  
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  map.root :controller => 'main', :action => 'index'
end