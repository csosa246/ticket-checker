# RSpec defines the default rake task to run specs.  This will
# add the jshint and rubocop tasks.
#
# NB: Rake task definition append tasks, rather than overwrite.
task default: %i(jasmine:ci jshint rubocop brakeman)

