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

require 'spec_helper'

describe Transaction do
  include MoneyRails::TestHelpers

  let(:user) { FactoryGirl.create :user }
  before do
    @transaction = user.transactions.build(
      date:         Date.today,
      amount:       10.00,
      description:  'Bought some things.'
    )
  end

  subject { @transaction }

  it { should respond_to :date }
  it { should respond_to :amount }
  it { should respond_to :description }
  it { should respond_to :user }
  its(:user) { should == user }

  it "validates presence of date" do
    @transaction.date = ' '
    @transaction.should_not be_valid
  end

  it "monetizes the amount" do
    monetize(:amount_cents).should be_true
  end

  it "belongs to a user" do
    @transaction.user = nil
    @transaction.should_not be_valid
  end

  it "validates length of description to be <255 chars" do
    @transaction.description = 'a' * 256
    @transaction.should_not be_valid
  end
end
