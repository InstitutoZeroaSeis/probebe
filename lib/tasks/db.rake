namespace :db do
  FILE = 'tmp/dump.sql'

  desc 'Dumps the database to tmp/dump.sql'
  task dump: :environment do
    command = "mysqldump #{command_options} > #{FILE}"
    puts "Dumping to #{FILE}"
    system command
  end

  desc 'Restore the databse from tmp/dump.sql'
  task restore: :environment do |file|
    command = "mysql #{command_options} < #{FILE}"
    puts 'Warning: This will delete all of your current data'
    puts 'If you really want to restore the database knowing you can loss your data. Type restore: '
    puts "Restoring from #{file}"
    system command
  end

  private

  def command_options
    c = ActiveRecord::Base.connection_config
    %W(
      --user=#{c[:username]}
      --password=#{c[:password]}
      --host=#{c[:host]}
      --port=#{c[:port]}
      #{c[:database]}
    ).join(' ')
  end
end
