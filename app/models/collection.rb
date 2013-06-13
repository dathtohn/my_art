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
  attr_accessible :date, :title, :link
  has_attached_file :cover
  belongs_to :user
  has_many :works

  validates :date, presence: true
  validates :link, presence: true
  validates_format_of :link,
  	with: %r{\.(gif|jpe?g|png)$}i,
  	message: "must have an image extension"
  validates :title, presence: true
  validates :user_id, presence: true

  default_scope order: 'collections.created_at DESC'

 	private

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

