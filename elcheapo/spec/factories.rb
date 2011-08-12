require 'factory_girl'

Factory.define :user do |u|
  u.name 'Test User'
  u.email 'cli@empathylab.com'
  u.password 'please'
  u.username 'cli'
  u.role 'user'
end

Factory.define :message do |u|
  u.content 'Lorem ipsum.'
end
