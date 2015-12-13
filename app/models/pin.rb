class Pin < ActiveRecord::Base
	belongs_to :user
	has_attached_file  :image, styles: { medium: "100x100>" }
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	acts_as_votable
end
