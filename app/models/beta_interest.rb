class BetaInterest < ActiveRecord::Base
  validates_uniqueness_of :email
  named_scope :created_today, :conditions => ['created_at BETWEEN ? AND ?', Time.now.utc.midnight, Time.now.utc.midnight.tomorrow]
end
