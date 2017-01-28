class User < ApplicationRecord
  rolify
  has_many :venues
  has_many :venue_reviews
  has_many :event_reviews
  has_many :comments
  has_many :ratings

  # resourcify

  has_many :events, through: :rsvp
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  # validates :first_name, :last_name, presence: true
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/defaultß.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter], authentication_keys: [:login]

  after_create :assign_role

  def assign_role
    add_role(:default)
  end

  attr_accessor :login
  #
  # def login=(login)
  #   @login = login
  # end
  #
  # def login
  #   @login || self.username || self.email
  # end


  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = lower(:value)", { :value => login }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        conditions[:email].downcase! if conditions[:email]
        where(conditions.to_h).first
      end
    end

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
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

  #  def self.new_with_session(params, session)
  #     super.tap do |user|
  #       if data = session["devise.twitter_data"] && session["devise.twitter_data"]["extra"]["raw_info"]
  #         user.email = data["email"] if user.email.blank?
  #       end
  #     end
  #   end

end
