namespace :db do
  task do: %w(migrate db:test:prepare)
  task redo: %w(migrate:redo test:prepare)
end

