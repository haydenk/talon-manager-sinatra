class AuthenticatedRequest
  include DataMapper::Resource
  include DataMapper::Validations

  property :id, Serial
  property :location, String
  property :field, String
  property :value, String

  belongs_to :request_id

  def to_json
    {
        location: self.location,
        field: self.field,
        value: self.value,
    }
  end
end
