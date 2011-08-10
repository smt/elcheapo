class Message
  include ActiveModel::Validations
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  #embeds_many :pictures

  field :content
  field :message_type
  field :alert, :type => Boolean
  field :sticky, :type => Boolean
  field :promoted, :type => Boolean
  field :expires_at, :type => DateTime
  field :duration_time, :type => BigDecimal
  field :cycle_time, :type => BigDecimal
  index :expires_at

  # queue should contain all sticky and unexpired messages
  scope :queue, any_of({ sticky: true }, { :expires_at.gte => Time.now }).desc(:alert, :sticky, :promoted, :updated_at)

  attr_accessible :message_type, :title, :content, :alert, :sticky, :promoted, :expires_at

  validates_presence_of :content

  before_validation :set_expiration
  before_validation :set_userstamp

  TYPES = %w[client internal] # use 'system' for automated messages

  protected

  def set_expiration
    self.expires_at = Time.now if self.expires_at.blank?
  end

  def set_userstamp
    self.user_id = current_user.id
  end
end
