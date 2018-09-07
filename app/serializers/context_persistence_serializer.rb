class ContextPersistenceSerializer < ActiveModel::Serializer
  attributes :interest_rate, :previous_interest_rate

  def interest_rate
    object.interest_rate * PRECISION_ADJUSTMENT_FACTOR
  end

  def previous_interest_rate
    object.previous_interest_rate * PRECISION_ADJUSTMENT_FACTOR
  end
end
