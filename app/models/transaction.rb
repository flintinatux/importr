# == Schema Information
#
# Table name: transactions
#
#  id              :integer          not null, primary key
#  date            :date             not null
#  kind            :string(255)      not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string(255)      default("USD"), not null
#  description     :string(255)
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Transaction < ActiveRecord::Base
  attr_accessible :date, :kind, :amount, :description, :user
  belongs_to :user

  after_initialize :set_defaults
  before_save   :correct_amount_sign
  after_create  :campfire_create_message
  after_update  :campfire_update_message
  after_destroy :campfire_destroy_message

  VALID_KINDS = %w(income expense)

  monetize :amount_cents

  validates_presence_of :date, :user

  validates :kind, inclusion: { in: VALID_KINDS }
  validates :amount, presence: true, exclusion: { in: [0.00], message: "Amount cannot be zero." }
  validates :description, presence: true, length: { maximum: 255 }

  default_scope order: 'date desc'

  private

    def campfire
      @campfire ||= Tinder::Campfire.new 'bquadrant', token: user.campfire_token
    end

    def campfire_create_message
      send_campfire_message 'created'
    end

    def campfire_update_message
      send_campfire_message 'edited'
    end

    def campfire_destroy_message
      send_campfire_message 'deleted'
    end

    def send_campfire_message(method)
      message = ":moneybag: [importr] -- #{method} transaction ##{id} -- #{date} -- #{description} for $#{amount.abs} -- net income: $#{user.net_income} -- http://importr.herokuapp.com :moneybag:"
      room.speak message if user.campfire_token?
    end

    def correct_amount_sign
      self.amount = amount.abs * (kind == 'income' ? 1 : -1)
    end

    def room
      @room ||= campfire.find_room_by_id 441315
    end

    def set_defaults
      self.kind ||= 'income'
    end
end
