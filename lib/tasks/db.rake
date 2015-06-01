namespace :db do
  DUMP_FILE = 'tmp/dump.sql'

  desc 'Dumps the database to tmp/dump.sql'
  task dump: :environment do
    command = "mysqldump #{command_options} > #{DUMP_FILE}"
    puts "Dumping to #{DUMP_FILE}"
    system command
  end

  desc 'Restore the databse from tmp/dump.sql'
  task restore: :environment do
    command = "mysql #{command_options} < #{DUMP_FILE}"
    puts 'Warning: This will delete all of your current data'
    puts 'If you want to stop press Ctrl-C in 10s'
    sleep 10
    puts "Restoring from #{DUMP_FILE}"
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
