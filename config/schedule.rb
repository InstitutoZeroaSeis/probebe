set :job_template, "bash -c ':job'"

every [:monday, :wednesday, :friday],  at: '11am' do
  runner 'MessageSenderWorker.perform_async(Date.today)'
  command 'echo "Running cron at $(date)" >> /app/log/cron.log '
  command 'curl -X POST http://localhost/api/d3d4b74ea38c163c820cd84b25f5/a8eecbf2d604ff6769fd64f1a491 >> /app/log/cron.log'
end
