class CommentsController < ApplicationController
	before_action :set_post

	def create
		@comment = @pin.comment.build(comment_params)
		@comment.user_id = current_user
		if @comment.save
			redirect_to pin_comment_path, notice: 'Commented'
		end
	end

	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to pin_comments_path, notice: 'Deleted comment'
	end

	private

	def comment_params
		params.require(:comment).permit(:description)
	end

	def set_post
		@pin = Pin.find(param[:pin_id])
	end
end
