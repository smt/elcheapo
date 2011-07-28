class Message
  include ActiveModel::Validations
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user
  #embeds_many :pictures

  field :title
  field :content
  field :message_type
  field :alert, :type => Boolean
  field :sticky, :type => Boolean
  field :promoted, :type => Boolean
  field :expires_at, :type => DateTime
  index :expires_at
  
  # queue should contain all sticky and unexpired messages
  scope :queue, any_of({ sticky: true }, { :expires_at.gte => Time.now }).desc(:alert, :sticky, :promoted, :updated_at)

  attr_accessible :message_type, :title, :content, :alert, :sticky, :promoted, :expires_at

  TYPES = %w[client internal] # use 'system' for automated messages
end
