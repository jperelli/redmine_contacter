require 'redmine'

# Patches to the Redmine core.
require 'dispatcher'

Dispatcher.to_prepare :redmine_resources do
  require_dependency 'issue'
  # Guards against including the module multiple time (like in tests)
  # and registering multiple callbacks
  unless Issue.included_modules.include? RedmineResources::IssuePatch
    Issue.send(:include, RedmineResources::IssuePatch)
  end
end

# activar el siguiente IF para instalar la bd con:
# RAILS_ENV=production rake db:migrate:plugin NAME="redmine_resources" VERSION=1

#if ActiveRecord::Base.connection.table_exists? :dependencias
	require_dependency 'resources_show_issue_hook'
#end
# It requires the file in lib/redmine_resources/hooks.rb
require_dependency 'redmine_resources/hooks'
require_dependency 'redmine_resources/issue_new'

Redmine::Plugin.register :redmine_resources do
  name 'redmine_contacter'
  author 'Julian Perelli'
  description 'Permite linkear dependencias a un issue. Basado en "Issue Resources" de Daniel Vandersluis'
  version '0.0.6'
  
   project_module :resources do |map|
    map.permission :view_resources, { }
    map.permission :add_resources, { :issue_resources => :new }
    map.permission :delete_resources, { :issue_resources => :destroy }
  end
  
  menu :top_menu, :redmine_resources, {:controller => 'dependencias', :action => 'index'}, :caption => :dependencias
  
end
