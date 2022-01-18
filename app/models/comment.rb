class Comment < ApplicationRecord
  belongs_to :user
  # belongs_to :send_user, class_name: 'User'

  validates :content, length: { maximum: 255, message: 'は255文字以内で登録してください' }
end
