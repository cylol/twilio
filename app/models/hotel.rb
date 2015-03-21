class Hotel < ActiveRecord::Base
  has_many :orders
end
