class BetaInterest < ActiveRecord::Base
  validates_uniqueness_of :email
  named_scope :unreported, :conditions => { :reported => false }

  def self.report
    unreported.each { |u| u.reported = true }
  end
end
