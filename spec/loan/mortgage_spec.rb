require 'rails_helper'

module Loan
  describe Mortgage do
    describe "#sufficient_down_payment?" do
      let(:subject) do
        described_class.new(
          30,
          "monthly",
          down_payment
        ).sufficient_down_payment?(amount)
      end

      context "loan is less than $500000" do
        let(:amount) { 250000 }

        context "down payment is less required" do
          let(:down_payment) { 12499 }

          it { is_expected.to be false }
        end

        context "down payment matches required amount" do
          let(:down_payment) { 12500 }

          it { is_expected.to be true }
        end

        context "down payment is greater than required" do
          let(:down_payment) { 15000 }

          it { is_expected.to be true }
        end
      end

      context "loan is greater than $500000" do
        let(:amount) { 750000 }

        context "down payment is less than required" do
          let(:down_payment) { 45000 }

          it { is_expected.to be false }
        end

        context "down payment matches required amount" do
          let(:down_payment) { 50000 }

          it { is_expected.to be true }
        end

        context "down payment is greater than required" do
          let(:down_payment) { 55000 }

          it { is_expected.to be true }
        end
      end
    end

    describe "#valid_mortgage_period?" do
      let(:subject) { described_class.valid_mortgage_period?(period) }

      context "mortgage period is less than accepted range" do
        let(:period) { 4 }

        it { is_expected.to be false }
      end

      context "mortgage period is greater than accepted range" do
        let(:period) { 26 }

        it { is_expected.to be false }
      end

      context "mortgage period is within the accepted range" do
        let(:period) { 20 }

        it { is_expected.to be true }
      end
    end
  end
end
