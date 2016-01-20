require File.expand_path(File.dirname(__FILE__) + "/environment")
# every [:monday, :wednesday, :friday],  at: '11am' do
#   url = Rails.application.config.server_url
#   command "curl -X POST #{url}/api/d3d4b74ea38c163c820cd84b25f5/a8eecbf2d604ff6769fd64f1a492 >> /app/log/cron.log"
#   #runner 'MessageSenderWorker.perform_async(Date.today)'
#   #command 'echo "Running cron at $(date)" >> /app/log/cron.log '

# end


every [:thursday],  at: '11am' do
  url = Rails.application.config.server_url
  command "curl -X POST #{url}/api/d3d4b74ea38c163c820cd84b25f5/a8eecbf2d604ff6769fd64f1a492 >> /app/log/cron.log"
  #runner 'MessageSenderWorker.perform_async(Date.today)'
  #command 'echo "Running cron at $(date)" >> /app/log/cron.log '

end
