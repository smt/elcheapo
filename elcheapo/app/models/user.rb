class User
  include ActiveModel::Validations
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  has_many :messages
  has_mongoid_attached_file :avatar

  field :name
  field :email
  field :username
  field :job_title
  field :role, :default => "user"
  field :start_date, :type => Date
  field :birth_date, :type => Date
  field :bio
  key :username

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :job_title, :start_date, :birth_date, :bio

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email, :case_sensitive => false
  validates_format_of :email, :with => /\@empathylab\.com^/, :message => "You must be an employee of Empathy Lab."

  before_validation :userify

  ROLES = %w[admin user]

  def role?(role)
    role.to_s == self.role
  end

  protected

  def userify
    self.username = email.split("@")[0] if self.username.blank?
  end
end

