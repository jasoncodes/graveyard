class CreateBetaInterests < ActiveRecord::Migration
  def self.up
    create_table :beta_interests do |t|
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :beta_interests
  end
end
