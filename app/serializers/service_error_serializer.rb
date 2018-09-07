class ServiceErrorSerializer < ActiveModel::Serializer
  attributes :errors

  def errors
    object.errors
  end
end
