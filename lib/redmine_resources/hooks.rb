module Redmine_resources
  class Hooks < Redmine::Hook::ViewListener
    # This just renders the partial in
    # app/views/hooks/_view_issues_form_details_bottom.rhtml
    # The contents of the context hash is made available as local variables to the partial.
    #
    # Additional context fields
    #   :issue  => the issue this is edited
    #   :f      => the form object to create additional fields
    ctx = { :dependencias => Dependencia.find(:all, :order => "nombre DESC") }
    render_on :view_issues_form_details_bottom, :partial => "issues/new_resources", :locals => ctx
  end
end