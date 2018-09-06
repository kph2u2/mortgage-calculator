require 'rails_helper'

# Just a few quick sanity checks for this class. Further testing is
# unwarranted as the specs would be unit testing the HashWithIndifferentAccess
# class.

module Amortization
  describe Frequency do
    describe "::payments_per_year" do
      let(:subject) { described_class.payments_per_year(frequency) }

      context "return payments per year for weekly" do
        let(:frequency) { "weekly" }
        it { is_expected.to eq(48) }
      end
    end

    describe "::valid_frequency?" do
      let(:subject) { described_class.valid_frequency?(frequency) }

      context "frequency is a valid value" do
        let(:frequency) { "weekly" }
        it { is_expected.to be true }
      end

      context "frequency is not a valid value" do
        let(:frequency) { "weekly_not" }
        it { is_expected.to be false }
      end
    end
  end
end
