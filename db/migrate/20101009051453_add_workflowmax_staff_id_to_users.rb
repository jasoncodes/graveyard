class AddWorkflowmaxStaffIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :workflowmax_staff_id, :integer
  end

  def self.down
    remove_column :users, :workflowmax_staff_id
  end
end
