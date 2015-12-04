class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :gift
  has_many :subscription_preferences
  has_many :preferences, :through => :subscription_preferences

  validates :recipient_first_name,
            :recipient_last_name,
            :shipping_address_line1,
            :shipping_city,
            :shipping_state,
            :shipping_zipcode,
            presence: true,
            allow_blank: false,
            allow_null: false,
            if: :new_record?
              

  scope :active, -> { where(status: "active") }
  scope :canceled, -> { where(status: "canceled") }
  scope :on_hold, -> { where("status='canceled' AND hold_time_end IS NOT NULL AND hold_time_end >= ?", Date.current) }

  before_save :set_status
  before_save :generate_referral_code, if: :new_record?


  def as_json(options = {})
    super(options).merge(on_hold: on_hold?)
  end

  def pending?
    status == "pending"
  end

  def on_hold?
    return false unless hold_time_start? && hold_time_end?

    hold_time_end >= Date.current
  end

  def canceled?
    status == "canceled" && !on_hold?
  end

  def status
    read_attribute(:status).presence || "pending"
  end

  def generate_referral_code
    $res = recipient_first_name.first+recipient_last_name.first+Array.new(4){rand 10}.join
    write_attribute :referral_code, user.try(:referral_code) || $res.upcase
  end

  def display_name
    n = "#{recipient_first_name} #{recipient_last_name}"
    n += " - joined #{created_at.strftime("%b %d, %Y")} "
    n += " - #{gift.name}" if gift
    n += " - ON HOLD" if on_hold?
    n += " - CANCELED" if canceled?
    n
  end


  private


  def set_status
    write_attribute :status, "pending" unless read_attribute(:stripe_identifier).present?
  end
end
