class WorkflowMax::Job < WorkflowMax::Base
  def self.all(date_from, date_to)
    list :query => { :from => date_from.strftime('%Y%m%d'), :to => date_to.strftime('%Y%m%d')}
  end
end
