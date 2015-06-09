every [:monday, :wednesday, :friday],  at: '11am' do
  command 'curl -X POST http://www.probebe.org.br/api/d3d4b74ea38c163c820cd84b25f5/a8eecbf2d604ff6769fd64f1a491'
  command 'echo "Running cron at $(date)" >> /app/log/cron.log '
end
