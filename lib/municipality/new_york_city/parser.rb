module Municipality::NewYorkCity::Parser

  private

  def parse_body(body)
    html_doc = Nokogiri::HTML(body) 
    violations_body(html_doc)
  end
  
  def violations_body(html_doc)
    violation_elements(html_doc).collect do |element|
      { title: title(element), amount: amount(element) }.merge(details(element))
    end
  end

  def violation_elements(html_doc)
    html_doc.css('div.violation-group-wrapper')
  end

  def title(element) 
    element.css('span.violation-title').text
  end

  def amount(element)
    element.css('span.violation-value').text
  end

  def details(element)
    d = {}
    detail_elements(element).each do |detail_element|
      detail_title = detail_element.css('span.violation-details-single-title').text
      detail_value = detail_element.css('span.violation-details-single-value1').text

      d[:id] = detail_value.to_i if detail_title.downcase.include?('violation')
      d[:date] = detail_value if detail_title.downcase.include?('issue date')
    end
    d
  end

  def detail_elements(element)
    element.css('ul.violation-details-list').css('li')
  end

end

