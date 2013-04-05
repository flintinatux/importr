# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  product         :string(255)
#  campfire_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :campfire_token, :email, :name, :product, :password, :password_confirmation
  has_secure_password

  has_many :transactions, dependent: :destroy

  before_save { self.email.downcase! }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, format: { with: VALID_EMAIL_REGEX, message: "Is not a valid email." },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, on: :create }

  def net_income
    transactions.map(&:amount).inject(:+) || Money.new(0.00)
  end

  def net_income_series
    net_income_each_day.sort.inject([start_point]) do |series, day|
      net_income = (series.last[1] + day[1]).round(2)
      series << [day[0], net_income]
      series
    end
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def date_in_ms(date)
      date.strftime('%s').to_i * 1000
    end

    def net_income_each_day
      transactions.inject({}) do |net_income, transaction|
        day = date_in_ms(transaction.date)
        net_income[day] ||= 0.00
        net_income[day] += transaction.amount.to_f
        net_income
      end
    end

    def start_point
      start_date = Date.new(2013, 2, 1)
      [date_in_ms(start_date), 0.00]
    end
end
