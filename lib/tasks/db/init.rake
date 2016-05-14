namespace :db do
  desc 'Create and load the database schema'
  task init: [:create, :schema] do
  end
end