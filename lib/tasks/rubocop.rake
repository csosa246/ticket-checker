task :rubocop do
  exit(1) unless system('rubocop')
end

