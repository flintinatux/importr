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
  after_initialize :set_defaults
  before_save :correct_amount_sign
  attr_accessible :date, :kind, :amount, :description, :user
  belongs_to :user

  VALID_KINDS = %w(income expense)

  monetize :amount_cents

  validates_presence_of :date, :user

  validates :kind, inclusion: { in: VALID_KINDS }
  validates :amount, presence: true, exclusion: { in: [0.00], message: "Amount cannot be zero." }
  validates :description, presence: true, length: { maximum: 255 }

  default_scope order: 'date desc'

  private

    def set_defaults
      self.kind ||= 'income'
    end

    def correct_amount_sign
      self.amount = amount.abs * (kind == 'income' ? 1 : -1)
    end
end
