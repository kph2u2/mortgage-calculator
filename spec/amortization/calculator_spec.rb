require 'rails_helper'

PERIOD_SAMPLING = (5..25).to_a.shuffle.take(3)
PAYMENT_SAMPLING = (500..10000).to_a.shuffle.take(3)
FREQUENCY_SAMPLING = [:monthly, :biweekly, :weekly]
LOAN_AMOUNT_SAMPLING = (100000..2000000).to_a.shuffle.take(3)

module Amortization
  describe 'Calculator' do
    describe '#principal_from_payment' do
      let(:subject) { Calculator.new(loan).principal_from_payment(payment) }
      let(:loan) { Loan::Mortgage.new(period, frequency) }

      # Try 3 samplings of mortgage period, frequency, and payment
      PERIOD_SAMPLING.each do |period|
        FREQUENCY_SAMPLING.each do |frequency|
          PAYMENT_SAMPLING.each do |payment|
            context "given a loan and a payment" do
              let(:period) { period }
              let(:frequency) { frequency }
              let(:payment) { payment }

              it { is_expected.not_to be_nil }
            end
          end
        end
      end
    end

    describe '#payment_from_principal' do
      let(:subject) { Calculator.new(loan).payment_from_principal(amount) }
      let(:loan) { Loan::Mortgage.new(period, frequency) }

      # Try 3 samplings of mortgage period, frequency, and loan amount
      PERIOD_SAMPLING.each do |period|
        FREQUENCY_SAMPLING.each do |frequency|
          LOAN_AMOUNT_SAMPLING.each do |amount|
            context "given a loan and a loan amount" do
              let(:period) { period }
              let(:frequency) { frequency }
              let(:amount) { amount }

              it { is_expected.not_to be_nil }
            end
          end
        end
      end
    end
  end
end
