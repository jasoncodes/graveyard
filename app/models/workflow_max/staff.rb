class WorkflowMax::Staff < WorkflowMax::Base
  def self.find_by_email email
    all.detect {|wm| wm.email == email}
  end
end
