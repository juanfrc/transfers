class Transfer < ActiveRecord::Base
	belongs_to :sender, class_name: "User", foreign_key: "sender_id"
	belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
	
	validates_numericality_of :amount, only_integer: true, greater_than: 0

	after_create :define_users, :create_transfer
	before_destroy :define_users, :destroy_transfer
	after_update :define_users, :update_transfer

	protected

		def define_users
			@sender = self.sender
			@receiver = self.receiver
			@amount = self.amount
		end

		def create_transfer
			@sender.update(balance: @sender.balance -= @amount)
			@receiver.update(balance: @receiver.balance += @amount)			
		end

		def destroy_transfer
			@sender.update(balance: @sender.balance += self.amount)
			@receiver.update(balance: @receiver.balance -= self.amount)
		end

		def update_transfer
			@sender.update(balance: sender.balance += self.amount_was - @amount)
			@receiver.update(balance: receiver.balance += @amount -self.amount_was)
		end
end
