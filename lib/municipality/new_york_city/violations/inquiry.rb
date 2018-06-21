class Municipality::NewYorkCity::Violations::Inquiry
  include Municipality::NewYorkCity::Client
  include Municipality::NewYorkCity::Parser

  def call
    # we will have municipality
    municipality = Municipality.find_by(name: "New York City")
    parse.each do |violation_attributes|
      puts violation_attributes
      # violation = municipality.violations.build
    end
  end

  def parse
    parse_body(fetch.body)
  end

  def fetch
    send_request(form_post)
    send_request(form_redirect)
  end

  private

  def form_post
    Net::HTTP::Post.new(post_path, headers).tap do |request|
      request.set_form_data(form_data)
    end
  end

  def form_redirect
    Net::HTTP::Get.new(redirect_path, headers)
  end

  def form_data
    {
      "args.PLATE": "license-plate",
      "args.STATE": "NY"
    }
  end

  def post_path
    ENV["NEW_YORK_CITY_POST_PATH"]
  end

  def redirect_path
    ENV["NEW_YORK_CITY_REDIRECT_PATH"]
  end

end

