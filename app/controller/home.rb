module MySinatraApp
  class App < BaseApp

    get '/' do
      slim :index
    end

  end
end
