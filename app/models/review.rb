class Review < ActiveRecord::Base
has_many :reviews
belongs_to :product
belongs_to :user

validates_presence_of :description
validates_presence_of :rating
validates_presence_of :product
validates_presence_of :user

end
