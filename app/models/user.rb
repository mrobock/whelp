class User < ApplicationRecord
  rolify
  has_many :venues
  has_many :venue_reviews
  has_many :event_reviews
  has_many :comments
  has_many :ratings
  has_many :events, through: :rsvp

  # resourcify

  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true

  validates :first_name, :last_name, presence: true

  has_attached_file :image, styles: { small: "64x64#", med: "100x100#", large: "350x275#", xlarge: "400x400#" }, :default_url => "profile_:style.jpeg"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Only allow letter, number, underscore and punctuation.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

  after_save :assign_role

  def assign_role
    add_role(:default)
  end

  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update_attribute(:deleted_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end 

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login


  def self.from_omniauth(auth)
    if auth.provider == "facebook"
      # was where(provider: auth.provider, uid: auth.uid).first_or_create do |user|)
      where(email: auth.info.email).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
          # Helper methods to split info coming in into username, first_name, last_name etc.
          name_array = auth.info.name.split(" ")
          email_array = auth.info.email.split("@")
        user.username = email_array[0]
          # auth.info.name.gsub(/\s+/, "")   # assuming the user model has a name
        user.first_name = name_array[0]
        user.last_name = name_array[1]
        user.image = URI.parse(auth.info.image) # assuming the user model has an image


        # uri = URI.parse(auth.info.image) if auth.info.image?
        # uri.scheme = 'https'
        # user.image = uri
        # If you are using confirmable and the provider(s) you use validate emails,
        # uncomment the line below to skip the confirmation emails.
        # user.skip_confirmation!
      end
    else
      # Was where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      where(username: auth.info.nickname).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        #if the email is not find from twitter, add in the user id as the twitter email.
        user.email = auth.info.email || "#{auth.uid}@twitter.com"
        user.password = Devise.friendly_token[0,20]
        user.username = auth.info.nickname
        name_array = auth.info.name.split(" ")
        user.first_name = name_array[0]
        user.last_name = name_array[1]
        user.image = auth.info.image
     end
    end
  end


  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = lower(:value)", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        conditions[:email].downcase! if conditions[:email]
        where(conditions.to_h).first
      end
    end
  #  def self.new_with_session(params, session)
  #     super.tap do |user|
  #       if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
  #         user.email = data["email"] if user.email.blank?
  #       end
  #     end
  #   end

end
