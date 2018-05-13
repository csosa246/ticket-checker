task :brakeman do
  exit(1) unless system('brakeman -q')
end

