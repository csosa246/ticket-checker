require 'csv'

module TemplateHandlers
  class CsvBuilder
    class << self
      def call(template)
        <<~TEMPLATE
          io = StringIO.new
          csv ||= CSV.new(io); #{template.source}
          io.tap(&:rewind).read
        TEMPLATE
      end
    end
  end
end

ActionView::Template.register_template_handler(:csvbuilder, TemplateHandlers::CsvBuilder)

