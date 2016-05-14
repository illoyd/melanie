namespace :db do
  desc 'Reset the database by deleting and init-ing, as appropriate'
  task reset: [:delete, :init] do
  end
end