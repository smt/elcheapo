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
  field :expires_at, :type => Time
  field :duration_time, :type => BigDecimal
  field :cycle_time, :type => BigDecimal
  index :expires_at

  # queue should contain all sticky and unexpired messages
  scope :queue, any_of({ sticky: true }, { :expires_at.gte => Time.now.utc }).desc(:alert, :sticky, :promoted, :updated_at)

  attr_accessible :message_type, :title, :content, :alert, :sticky, :promoted, :expires_at

  validates_presence_of :content

  TYPES = %w[client internal] # use 'system' for automated messages
  EXPIRATION_OPTIONS = [
    { :text => "1 hour",  :value => 3600 },
    { :text => "1 day",   :value => 3600*24 },
    { :text => "1 week",  :value => 3600*24*7 },
    { :text => "1 month", :value => 3600*24*30 }
  ]

  def self.cache_hashtag_tweets
    logger.info "Caching tweets!"
    Message.create({:content => "I am a system-generated message!"})
  end

end
