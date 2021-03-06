require 'rails_helper'

module Loan
  describe Insurance do
    describe "#cost" do
      let(:subject) { described_class.new(amount, down_payment).cost.dollars }
      let(:down_payment) { build(:money, value: 50000) }
      let(:amount) { build(:money, value: 500001) }

      context "insurable loan amount over maximum threshold" do
        let(:amount) { build(:money, value: 11000000) }
        it { is_expected.to eq(0) }
      end

      context "down payment percentage above the maximum threshold" do
        let(:down_payment) { build(:money, value: 1100000) }
        it { is_expected.to eq(0) }
      end

      context "down payment percentage below minimum threshold" do
        let(:down_payment) { build(:money, value: 249700) }
        it { is_expected.to eq(0) }
      end

      context "down payment percentage in the 5-9.99% range" do
        let(:down_payment) { build(:money, value: 25500) }
        it { is_expected.to eq(15750.03) }
      end

      context "down payment percentage in the 10-14.99% range" do
        let(:down_payment) { build(:money, value: 55000) }
        it { is_expected.to eq(12000.02) }
      end

      context "down payment percentage in the 15%-19.99% range" do
        let(:down_payment) { build(:money, value: 78000) }
        it { is_expected.to eq(9000.02) }
      end
    end
  end
end
