class User < ActiveRecord::Base
	has_many :transfers
	
	validates :name, presence: true
	validates_numericality_of :balance, only_integer: true
end
