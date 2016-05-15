namespace :email do
  desc 'Load all emails'
  task demo: [:environment] do

    # Collect all files
    puts 'Beginning email loading'
    Dir[Rails.root.join('./spec/examples/**/*.eml')].each do |file|
      print "Loading #{ file }..."
      message = Mail.read(file)
      ProcessEmailJob.new.perform(message)
      puts 'ok'.green
    end

  end
end