class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  before_create :link_to_workflow_max

  def link_to_workflow_max
    staff = WorkflowMax::Staff.find_by_email(self.email)
    if staff.nil?
      errors.add :email, 'is not a valid WorkflowMax staff email address.'
      false
    else
      self.workflowmax_staff_id = staff.id
    end
  end

end
