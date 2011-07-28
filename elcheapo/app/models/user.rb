class User
  include ActiveModel::Validations
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  has_many :messages, index: true
  has_mongoid_attached_file :avatar

  field :name
  field :email
  field :job_title
  field :role, :default => "user"
  field :start_date, :type => Date
  field :birth_date, :type => Date
  field :bio
  key :name

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :job_title, :start_date, :birth_date, :bio

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email, :case_sensitive => false

  ROLES = %w[admin user]

  def role?(role)
    role.to_s == self.role
  end
end

