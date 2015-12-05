class User < ActiveRecord::Base
  authenticates_with_sorcery!


  validates :email,
            presence: true,
            uniqueness: true


  validates :first_name,
            :last_name,
            :phone_number,
            presence: true

  validates :password,
            length: { minimum: 6 }

  # Assign this based of the Promo Code in the form, or the cookie
  # set when a user clicks on a referral link
  has_one :referring_user, class_name: "User"

  has_many :subscriptions, -> { where(is_gift: false) }
  has_one :active_subscription, -> { where(is_active: true) }, class_name: "Subscription"
  has_many :gift_subscriptions, -> { where(is_gift: true) }, class_name: "Subscription"

  before_save :set_referral_code, if: -> (rec) { rec.new_record? && !rec.admin? }
  before_save :set_referring_user, if: :new_record?
  before_save :validate_email_confirmation
  after_save :set_referral_codes

  attr_accessor :referring_user_code
  attr_accessor :email_confirmation

  def validate_email_confirmation
    errors.add :email, "Does not match confirmation" unless email == email_confirmation
  end

  def set_referral_code
    write_attribute :referral_code, SecureRandom.hex(5)
  end

  def set_referral_codes
    Subscription.where(user_id: id).update_all(referral_code: referral_code)
  end

  def set_referring_user
    write_attribute :referring_user_id, User.where(referral_code: referring_user_code).pluck(:id)
  end

  def display_name
    "#{first_name} #{last_name}"
  end

end
