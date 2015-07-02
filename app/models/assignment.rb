# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  image_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_assignments_on_image_id  (image_id)
#  index_assignments_on_user_id   (user_id)
#

class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :image

  validates_associated :user, :image
  validates_presence_of :user, :image
end
