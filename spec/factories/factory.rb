FactoryBot.define do
  factory :money do
    initialize_with { new(value * 100) }
  end
end
