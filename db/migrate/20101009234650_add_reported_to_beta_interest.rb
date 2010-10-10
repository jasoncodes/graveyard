class AddReportedToBetaInterest < ActiveRecord::Migration
  def self.up
    add_column :beta_interests, :reported, :boolean, :default => false

    add_index :beta_interests, :reported
  end

  def self.down
    remove_column :beta_interests, :reported
  end
end
