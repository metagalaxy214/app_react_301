class SubscriptionPreference < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :preference
end