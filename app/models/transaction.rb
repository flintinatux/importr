# == Schema Information
#
# Table name: transactions
#
#  id              :integer          not null, primary key
#  date            :date             not null
#  amount_cents    :integer          default(0), not null
#  amount_currency :string(255)      default("USD"), not null
#  description     :string(255)
#  user_id         :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Transaction < ActiveRecord::Base
  attr_accessible :date, :amount, :description, :user
  belongs_to :user

  monetize :amount_cents

  validates_presence_of :date
  validates_presence_of :user

  validates :description, length: { maximum: 255 }

  default_scope order: 'date desc'
end
