require 'uri'

module MySinatraApp
  class App < BaseApp

    get '/scheduled-request', :provides => 'html' do
      @show_home_link = true
      scheduled_requests = ScheduledRequest.all
      slim 'scheduled_request/list'.to_sym, {
          :locals => {
              no_items: scheduled_requests.count == 0,
              scheduled_requests: scheduled_requests,
              actions_template: 'scheduled_request/actions'.to_sym
          }
      }
    end

    get '/scheduled-request/new', :provides => %w(html json) do
      @show_home_link = true
      step = params[:step] ||= 1
      auth_type = params[:auth_type] ||= 'none'

      slim 'scheduled_request/new'.to_sym, {:locals =>  {
          auth_type: auth_type,
          current_step: step
      }}
    end

    post '/scheduled-request', :provides => %w(html json) do
      @show_home_link = true
      step = params[:step].to_i ||= 1
      auth_type = params[:auth_type] ||= 'none'
      template_locals = {
          auth_type: auth_type,
          current_step: step
      }

      case step
      when 2
        full_url = URI.parse(params[:url])
        base_uri = "#{full_url.scheme}://#{full_url.host}"
        if full_url.port != full_url.default_port
          base_uri << ":#{full_url.port}"
        end
        template_locals[:base_uri] = base_uri
        template_locals[:path] = full_url.path
      when 3
        params.delete('step')
        if auth_type.downcase == 'basic'
          credentials = params[:credentials]
          params[:credentials] = BasicAuthRequest.create_credentials(credentials[:username], credentials[:password])
        end
        scheduled_request = ScheduledRequest.first_or_create({base_uri: params[:base_uri]}, params)
        if scheduled_request.id
          scheduled_request.update(params)
        end
        redirect '/scheduled-request'
      else
        # type code here
      end

      slim 'scheduled_request/new'.to_sym, {:locals => template_locals}
    end


  end
end
