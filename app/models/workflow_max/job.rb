class WorkflowMax::Job < WorkflowMax::Base
  def self.all(date_range)
    list :query => date_range_query(date_range)
  end

  def self.find_all_by_staff_id(staff_id)
    list :path => "/#{api_name}/staff/#{staff_id}"
  end
end
