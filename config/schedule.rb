set :job_template, "bash -c ':job'"

every [:monday, :wednesday, :friday],  at: '11am' do
  runner 'MessageSenderWorker.perform_async(Date.today)'
  command 'echo "Running cron at $(date)" >> /app/log/cron.log '
end
