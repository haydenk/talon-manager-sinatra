require 'aws-sdk-sqs'  # v2: require 'aws-sdk'

module MySinatraApp
  class App < BaseApp

    get '/url-download', :provides => 'html' do
      @show_home_link = true
      urls = UrlDownloadRequest.all
      slim 'url_download/list'.to_sym, {
          :locals => {urls: urls}
      }
    end

    get '/url-download/new', :provides => 'html' do
      @show_home_link = true
      slim 'url_download/new'.to_sym
    end

    post '/url-download' do
      auth_type = params[:auth_type] ||= 'none'
      if auth_type.downcase == 'basic'
        credentials = params[:credentials]
        params[:credentials] = BasicAuthRequest.create_credentials(credentials[:username], credentials[:password])
      end
      url_request = UrlDownloadRequest.first_or_create({url: params[:url], status: 'Pending'}, params)
      sqs = Aws::SQS::Client.new
      sqs_creds = nil
      if auth_type != 'none'
        sqs_creds = url_request.credentials.to_json
      end
      message_body = {
          id: url_request.id,
          url: url_request.url.to_s,
          auth_type: url_request.auth_type,
          credentials: sqs_creds
      }
      sqs.send_message(queue_url: ENV['URL_DOWNLOADER_SQS'], message_body: message_body.to_json)
      redirect '/url-download'
    end

  end
end
