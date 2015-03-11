class User < ActiveRecord::Base
	validates :name, presence: true
	validates_numericality_of :balance, only_integer: true
end
