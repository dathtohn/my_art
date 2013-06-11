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
  belongs_to :user
  has_many :works

  validates :date, presence: true
  validates :link, presence: true
  validates :title, presence: true
  validates :user_id, presence: true
end
