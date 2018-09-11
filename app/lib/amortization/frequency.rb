module Amortization
  class Frequency
    PAYMENTS_PER_YEAR = HashWithIndifferentAccess.new({
      monthly: 12,
      biweekly: 24,
      acc_biweekly: 26,
      weekly: 48,
      acc_weekly: 52,
    }).freeze

    def self.payments_per_year(payment_frequency)
      PAYMENTS_PER_YEAR[payment_frequency]
    end

    def self.valid_frequencies
      PAYMENTS_PER_YEAR.keys
    end

    def self.valid_frequency?(frequency)
      PAYMENTS_PER_YEAR.keys.include?(frequency)
    end
  end
end
