class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, dependent: :destroy
  has_many :expenses, dependent: :destroy
  
  has_many :sent_conversations, class_name: 'Conversation',
           foreign_key: 'sender_id', dependent: :destroy
  has_many :received_conversations, class_name: 'Conversation',
           foreign_key: 'recipient_id', dependent: :destroy
  has_many :messages, dependent: :destroy

  def conversations
    Conversation.where('sender_id = ? OR recipient_id = ?', id, id)
  end

  def full_name
    email.split('@').first.titleize
  end
end
