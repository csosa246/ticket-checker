module Municipality::NewYorkCity::Client

  private

  def send_request(request)
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end

  def uri
    URI.parse(ENV['NEW_YORK_CITY_URI'])
  end

  def headers
    {
      "Cookie": "ASP.NET_SessionId=#{session_id}"
    }
  end

  def session_id
    session.cookies.detect { |cookie| cookie.name == "ASP.NET_SessionId" }.value
  end

  def session 
    @session ||= Mechanize.new.tap do |a|
      a.get(session_url)
    end
  end

  def session_url
    ENV["NEW_YORK_CITY_SESSION_URL"]
  end

  def success?(responsed)
    response.code.to_i / 100 == 2
  end

  def raise_error!(response)
    case response.code.to_i
    when 401
      raise Homer::Delivery::Error::Unauthenticated.new(login: login, token: token)
    when 404
      raise Homer::Delivery::Error::NotFound.new(type: 'Order', action: 'create')
    when 422
      raise Homer::Delivery::Error::ResourceInvalid.new(type: 'Order', action: 'create')
    else
      raise Homer::Delivery::Error::Unspecified.new(response)
    end
  end
end


