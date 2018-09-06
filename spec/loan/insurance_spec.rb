require 'rails_helper'

module Loan
  describe Insurance do
    describe "#cost" do
      let(:subject) { described_class.new(amount, down_payment).cost }
      let(:down_payment) { 50000 }
      let(:amount) { 500001 }

      context "insurable loan amount over maximum threshold" do
        let(:amount) { 1100000 }

        it { is_expected.to eq(0) }
      end

      context "down payment percentage above the maximum threshold" do
        let(:down_payment) { 110000 }

        it { is_expected.to eq(0) }
      end

      context "down payment percentage below minimum threshold" do
        let(:down_payment) { 24970 }

        it { is_expected.to eq(0) }
      end

      context "down payment percentage in the 5-9.99% range" do
        let(:down_payment) { 25500 }

        it { is_expected.to eq(15750.03) }
      end

      context "down payment percentage in the 10-14.99% range" do
        let(:down_payment) { 55000 }

        it { is_expected.to eq(12000.02) }
      end

      context "down payment percentage in the 15%-19.99% range" do
        let(:down_payment) { 78000 }

        it { is_expected.to eq(9000.02) }
      end
    end
  end
end
