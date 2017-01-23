require 'bundler'
Bundler.require

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:   :staticfile,
  database:  './db/'
)

class User < ActiveRecord::Base
end

p User.all
