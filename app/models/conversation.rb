class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: User
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User

  validates :sender_id, uniqueness: { scope: :recipient_id }

  after_create :send_message

  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def send_message
    begin
      if recipient.admin?
        client = Twilio::REST::Client.new ENV['account_sid'], ENV['auth_token']
        text = 'some one  try to connect you ' + ENV["domain_name"]+"?user_id=user1"
        client.messages.create(from: '+14233972183',to: recipient.phone_number, body: text)
      end
    rescue
    end
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end
end
