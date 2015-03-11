class Transfer < ActiveRecord::Base
	belongs_to :user
	
	validates_numericality_of :amount, only_integer: true, greater_than: 0

	after_create :create_transfer_sender_receiver_balance
	before_destroy :destroy_sender_receiver_balance
	after_update :update_sender_receiver_balance


	protected
		def create_transfer_sender_receiver_balance	
			@transfer = self

			@sender = User.find(@transfer.sender_id)
			@sender_balance = @sender.balance
			@sender_balance -= @transfer.amount
			@sender.update(balance: @sender_balance)

			@receiver = User.find(@transfer.receiver_id)
			@receiver_balance = @receiver.balance
			@receiver_balance += @transfer.amount
			@receiver.update(balance: @receiver_balance)			
		end

		def destroy_sender_receiver_balance
			@transfer = self

			@sender = User.find(@transfer.sender_id)
			@sender_balance = @sender.balance
			@sender_balance += @transfer.amount
			@sender.update(balance: @sender_balance)

			@receiver = User.find(@transfer.receiver_id)
			@receiver_balance = @receiver.balance
			@receiver_balance -= @transfer.amount
			@receiver.update(balance: @receiver_balance)
		end

		def update_sender_receiver_balance
			@transfer = self

			@sender = User.find(@transfer.sender_id)
			@sender_balance = @sender.balance
			@sender_balance += @transfer.amount_was - @transfer.amount
			@sender.update(balance: @sender_balance)

			@receiver = User.find(@transfer.receiver_id)
			@receiver_balance = @receiver.balance
			@receiver_balance += @transfer.amount - @transfer.amount_was
			@receiver.update(balance: @receiver_balance)

		end
end
