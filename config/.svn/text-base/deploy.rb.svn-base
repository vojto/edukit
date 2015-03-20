set :application, "edukit"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"
set :deploy_to, "/var/www/projects/_deploy/edukit"
set :deploy_via, :copy
set :repository, "/Users/vojto/Sites/projects/rschoolr"
set :scm, :none

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion
# set :scm_command, "/home/riniknet/bin/bin/svn"

role :app, "edukit.sk"
role :web, "edukit.sk"
role :db,  "edukit.sk", :primary => true

set :user, "root"
set :user_sudo, false