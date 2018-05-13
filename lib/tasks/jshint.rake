task :jshint do
  command = 'find app/assets/javascripts spec/javascripts -name *.js | xargs jshint'
  exit(1) unless system(command)
end

