class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :body, presence: true
  validates :conversation_id, presence: true
  validates :user_id, presence: true

  def message_time
    created_at.strftime("%m/%d/%Y at %l:%M %p")
  end
end ### End of Message Class
