require 'factory_girl'

Factory.define :user do |u|
  u.name 'Test User'
  u.email 'cli@empathylab.com'
  u.password 'please'
  u.username 'cli'
  u.role 'user'
end

Factory.define :message do |m|
  m.content 'Lorem ipsum.'
  m.expires_at Time.now.utc + 3600
  m.category 'Dolor sit amet'
end

Factory.define :category do |c|
  c.name 'Generic Message'
end
