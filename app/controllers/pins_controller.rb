class PinsController < ApplicationController
	before_action :find_pin, only: [:show, :edit, :update, :destroy, :upvote]
	before_action :authenticate_user!, except: [:index, :show, :upvote]

	def index
		@pins = Pin.all.order("created_at DESC")
	end

	def new
		@pin = current_user.pins.build
	end

	def create
		@pin = current_user.pins.build(pin_params)
		if @pin.save
			redirect_to @pin, notice: "Successfully created pin"
		else
			render 'new'
		end
	end

	def show
		@comment = @pin.comments
	end

	def edit
	end

	def update
		if @pin.update(pin_params)
			redirect_to @pin, notice: "Successfully updated"
		else
			render :edit
		end
	end

	def destroy
		@pin.destroy
		redirect_to root_path
	end

	def upvote
		@pin.liked_by current_user
		redirect_to @pin
	end

	private
	def pin_params
		params.require(:pin).permit(:title, :description, :image)
	end

	def find_pin
		@pin = Pin.find(params[:id])
	end
end
