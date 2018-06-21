fixture_paths = Module.new do
  class << self
    def ordered
      ordered_tables.collect { |table| path_for(table) }
    end

    def unordered
      Dir.glob(path_for('*')) - ordered
    end

    private

    def ordered_tables
      %w(users municipalities violations)
    end

    def path_for(file)
      Rails.root.join("spec", "fixtures", "#{file}.rb").to_s
    end
  end
end

# Make sure all test doubles are in place for the fixture build.
Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

FixtureBuilder.configure do |builder|
  # rebuild fixtures automatically when these files change:
  builder.files_to_check += Dir['spec/support/fixture_builder.rb', 'db/structure.sql', 'spec/fixtures/*.rb']

  builder.factory do
    fixture_paths.ordered.each do |path|
      File.open(path) { |file| instance_eval(file.read) }
    end

    fixture_paths.unordered.each do |path|
      File.open(path) { |file| instance_eval(file.read) }
    end
  end
end

