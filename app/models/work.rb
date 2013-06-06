# == Schema Information
#
# Table name: works
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  collection_id :integer
#  link          :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Work < ActiveRecord::Base
  attr_accessible :collection_id, :link, :title
  belongs_to :collection

# validates_format_of :image, :with => %r{\.(png|jpg|jpeg)$}i, :message => "whatever"

  validates :collection_id, presence: true
  VALID_LINK_REGEX = %r{\.(png|jpg|jpeg|gif)$}i
  validates :link, presence: false, format: { with: VALID_LINK_REGEX }
  validates :title, presence: true
end
