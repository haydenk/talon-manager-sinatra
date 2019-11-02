class ScheduledRequestPath
  include DataMapper::Resource
  include DataMapper::Validations

  property :id, Serial
  property :uri, Text, :required => true
  property :interval, String

  # belongs_to :scheduled_request, :model => 'ScheduledRequest'
end

class ScheduledRequest
  include DataMapper::Resource
  include DataMapper::Validations

  property :id, Serial
  property :base_uri, Text, :required => true
  property :auth_type, String

  # has n, :paths, 'ScheduledRequestPath'
  # has 1, :credentials, :through => :request_id, :model => 'AuthenticatedRequest'

  after :update do
    if auth_type == 'none' and credentials
      credentials.destroy
    end
  end
end
