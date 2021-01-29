class Friendship < ApplicationRecord
  validates_uniqueness_of :sender_id, scope: [:receiver_id]
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
end
