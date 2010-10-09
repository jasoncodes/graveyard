class WorkflowMax::Job < WorkflowMax::Base
  def self.all(date_from, date_to)
    list :query => { :from => date_from.strftime('%Y%m%d'), :to => date_to.strftime('%Y%m%d')}
  end

  def self.find_by_staff_id(staff_id)
    list :path => "/#{api_name}/staff/#{staff_id}"
  end
end
