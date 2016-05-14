namespace :db do
  desc 'Reset the database by creating and seeding'
  task bootstrap: [:init, :seed] do
  end
end