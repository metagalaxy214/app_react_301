# Set a signed, permanent cookie when a user visits with a link
# that has a referral code, unless one is already set
# Cookie will be deleted once they create an account
# and the referring_user will be set on their user

# Tested in the SubscribeController spec
module UserReferralTracking

  def user_referred_by_code
    secure_permanent_cookies[:referral_code]
  end

  def self.included(base)
    base.class_eval do
      helper_method :user_referred_by_code
      before_action :set_user_referral_cookie, unless: -> {
        current_user.present? || secure_permanent_cookies[:referral_code].present?
      }
    end
  end

  def set_user_referral_cookie
    secure_permanent_cookies[:referral_code] = referral_cookie if referral_cookie.present?
  end

  def referral_cookie
    params[:referrer].to_s
  end

  def secure_permanent_cookies
    cookies.signed.permanent
  end
end
