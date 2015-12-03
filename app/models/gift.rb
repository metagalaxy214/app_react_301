
class Gift < ActiveRecord::Base
  has_many :subscriptions

  validates :amount, numericality: { only_integer: true, greater_than: 0 }

  mount_uploader :image, GiftImageUploader

  def name
    title
  end

  def display_name
    "#{title} - #{weeks} weeks"
  end
end
