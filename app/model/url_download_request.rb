require_relative 'authenticated_request'

class UrlDownloadRequest
  include DataMapper::Resource
  include DataMapper::Validations

  property :id, Serial
  property :url, Text, :required => true
  property :status, String
  property :auth_type, String
  property :created_at, DateTime
  property :updated_at, DateTime

  has 1, :credentials, 'AuthenticatedRequest'

  validates_presence_of :url

  before :save do
    if self.credentials.nil?
      self.auth_type = 'none'
    end
    if self.status.nil?
      self.status = 'Pending'
    end
  end

  def status_badge_class
    case self.status.downcase
    when 'pending'
      'm-badge--brand'
    when 'completed'
      'm-badge--success'
    else
      'm-badge--metal'
    end
  end

end
