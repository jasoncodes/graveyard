class WorkflowMax::Staff < WorkflowMax::Base
  def self.find_by_email email
    all.detect {|wm| wm.email == email}
  end

  def jobs
    @jobs ||= WorkflowMax::Job.find_all_by_staff_id self.id
  end
end
