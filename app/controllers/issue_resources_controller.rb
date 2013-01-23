class IssueResourcesController < ApplicationController
  before_filter :find_project, :authorize
  
  def new
    @resource = IssueResource.new(params[:resource])
    @resource.issue = @issue
	@resource.dependencia_id = params[:dependencia_id]
    @resource.save if request.post?
    respond_to do |format|
      format.html { redirect_to :controller => 'issues', :action => 'show', :id => @issue }
      format.js do
        render :update do |page|
          page.replace_html "resources", :partial => 'issues/resources', :locals => {:issue => @issue, :project => @project, :dependencias => Dependencia.find(:all, :order => "nombre DESC")}
          if @resource.errors.empty?
            page << "$('resource_resource').value = ''"
            page << "$('resource_description').value = ''"
          end
        end
      end
    end
  end

  def destroy
    resource = IssueResource.find(params[:id])
    if request.post? && @issue.resources.include?(resource)
      resource.destroy
      @issue.reload
    end
    respond_to do |format|
      format.html { redirect_to :controller => 'issues', :action => 'show', :id => @issue }
      format.js { render(:update) { |page| page.replace_html "resources", :partial => 'issues/resources', :locals => {:issue => @issue, :project => @project, :dependencias => Dependencia.find(:all, :order => "nombre DESC")} } }
    end
  end

private
  def find_project
    @issue = Issue.find(params[:issue_id])
    @project = @issue.project
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
