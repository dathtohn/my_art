# == Schema Information
#
# Table name: collections
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  date       :date
#  link       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Collection < ActiveRecord::Base
  attr_accessible :date, :title, :description, :cover
  has_attached_file :cover, styles: { thumb: "100x100#" },
				  									url: "/assets/collections/:id/:style/:basename.:extension",
				  									path: ":rails_root/public/assets/collections/:id/:style/:basename.:extension"
  belongs_to :user
  has_many :works
  has_many :comments, as: :commentable

  validates :date, presence: true
  validates :title, presence: true
  validates :user_id, presence: true

  default_scope order: 'collections.date DESC'

 	private

 	 #  validates_format_of :link,
  	# with: %r{\.(gif|jpe?g|png)$}i,
  	# message: "must have an image extension"

	  def link_is_valid_image
	    url = URI.parse(self.link)
	    Net::HTTP.start(url.host, url.port) do |http|
	      response = http.head(url.path)
	      case response
	      when Net::HTTPSuccess, Net::HTTPRedirection
	        case response.content_type
	        when "image/png", "image/gif", "image/jpeg", "image/jpg"
	          return true
	        else
	          errors.add(:link, 'Link is not valid image.')
	        end
	      else
	        errors.add(:link, 'Link does not exist.')
	      end
	    end
	  end
end

