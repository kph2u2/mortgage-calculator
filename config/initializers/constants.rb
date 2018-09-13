DEFAULT_INTEREST_RATE = 0.25.to_d
PRECISION_ADJUSTMENT_FACTOR = 100
module SimpleParams
  class MoneyParam < Virtus::Attribute
    def coerce(value)
      Money.new(value.to_d * 100)
    end
  end
  TYPE_MAPPINGS[:money] = MoneyParam
end
