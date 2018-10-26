class Conversation < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  ### lets ActiveRecord know sender_id and receiver_id are both ids from the user table
  has_many :messages, dependent: :destroy
  validates :sender_id, uniqueness: { scope: :receiver_id}

  def self.between(sender_id, receiver_id)
    where("(conversations.sender_id = ? AND conversations.receiver_id = ?) OR (conversations.receiver_id = ? AND conversations.sender_id = ?)", sender_id, receiver_id, sender_id, receiver_id)
  end

  # scope :between, -> (sender_id,receiver_id) do
  #   where("(conversations.sender_id = ? AND conversations.receiver_id = ?) OR (conversations.receiver_id = ? AND conversations.sender_id = ?)", sender_id, receiver_id, sender_id, receiver_id)
  #   end

  ### Determines if current_user is sender or receiver
  def recipient(current_user)
   if self.sender_id == current_user.id
     self.receiver
   else
     self.sender
   end
  end

  def unread_message_count(current_user)
   self.messages.where("user_id != ? AND read = ?", current_user.id, false).count
  end

  def conversation_user
    @user = User.find(self.receiver_id)
  end

end ### End of Conversation Class
