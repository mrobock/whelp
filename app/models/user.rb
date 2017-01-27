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
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/defaultß.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Only allow letter, number, underscore and punctuation.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:login]
# Omniauth
  devise :omniauthable, omniauth_providers: [:facebook]

  after_create :assign_role

  def assign_role
    add_role(:default)
  end

  # Virtual attribute for authenticating by either username or email
   # This is in addition to a real persisted field like 'username'
  attr_accessor :login

# Extra method to also authorize via login value (email or username). Not needed unless login methods are going to be used elsewhere.
  # def login=(login)
  #   @login = login
  # end
  #
  # def login
  #   @login || self.username || self.email
  # end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
        # Helper methods to split info coming in into username, first_name, last_name etc.
        name_array = auth.info.name.split(" ")
        email_array = auth.info.email.split("@")
      user.username = email_array[0]
        # auth.info.name.gsub(/\s+/, "")   # assuming the user model has a name
      user.first_name = name_array[0]
      user.last_name = name_array[1]

      # uri = URI.parse(auth.info.image) if auth.info.image?
      # uri.scheme = 'https'
      # user.image = uri
      user.image = URI.parse(auth.info.image) # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
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

end
