module Redmine_resources
  class Hooks < Redmine::Hook::ViewListener
    def controller_issues_new_after_save(context={ })
		params = context[:params]
		@resource = IssueResource.new()
		@resource.issue = context[:issue]
		@resource.dependencia_id = params[:dependencia_id]
		@resource.save
    end
  end
end