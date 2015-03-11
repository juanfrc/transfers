class TransfersController < ApplicationController

	def new
		@transfer = Transfer.new
	end

	def create
		@transfer = Transfer.new(transfer_params)

		if @transfer.sender_id == @transfer.receiver_id
			render 'new'
		else
			if @transfer.save
				redirect_to root_path
			else
				render 'new'
			end
		end
	end

	def edit
		@transfer = Transfer.find(params[:id])
	end

	def update
		@transfer = Transfer.find(params[:id])

		if @transfer.update(transfer_params)
			redirect_to root_path
		else
			render 'edit'
		end		
	end

	def destroy
		@transfer = Transfer.find(params[:id])
		@transfer.destroy
		redirect_to root_path
	end
	
	private
		def transfer_params
			params.require(:transfer).permit(:sender_id, :amount, :receiver_id)
		end

end
