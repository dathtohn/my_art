# == Schema Information
#
# Table name: works
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :string(255)
#  collection_id      :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class Work < ActiveRecord::Base
	include PublicActivity::Common
	
  attr_accessible :title, :description, :photo
  has_attached_file :photo, styles: { thumb: "500x500#" },
				  						storage: :s3,
                      s3_credentials: S3_CREDENTIALS,
                      default_url: "/images/myart.png",
                      path: "/:attachment/:id/:style.:extension"
  belongs_to :collection
  has_many :comments, as: :commentable, dependent: :destroy

  validates :collection_id, presence: true
  # VALID_LINK_REGEX = %r{\.(png|jpg|jpeg|gif)$}i
  validates :title, presence: true
end
