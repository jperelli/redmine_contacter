class IssueResource < ActiveRecord::Base
  belongs_to :issue
  belongs_to :dependencia

  validates_presence_of :issue_id, :dependencia_id
  validates_uniqueness_of :dependencia_id, :scope => :issue_id

end
