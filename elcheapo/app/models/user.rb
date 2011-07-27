class User
  include Mongoid::Document
  include Mongoid::Paperclip
  field :provider, :type => String
  field :uid, :type => String
  field :name, :type => String
  field :email, :type => String
  attr_accessible :provider, :uid, :name, :email

  has_mongoid_attached_file :avatar,
    :styles => {
      :thumb => "100x100#",
      :small => "150x150>",
      :medium => "200x200" }

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['user_info']
        user.name = auth['user_info']['name'] if auth['user_info']['name'] # Twitter, Google, Yahoo, GitHub
        user.email = auth['user_info']['email'] if auth['user_info']['email'] # Google, Yahoo, GitHub
      end
      if auth['extra'] && auth['extra']['user_hash']
        user.name = auth['extra']['user_hash']['name'] if auth['extra']['user_hash']['name'] # Facebook
        user.email = auth['extra']['user_hash']['email'] if auth['extra']['user_hash']['email'] # Facebook
      end
    end
  end

end

