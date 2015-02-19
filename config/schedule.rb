# This app runs in a server located in N. Virginia,
# and theere is a difference of two hours between, Sao Paulo
# and N. Virginia, so we setup whenever to run at 1 pm N. Virgina
# the tasks will be run at 11 am in Sao Paulo
every [:monday, :wednesday, :friday],  at: '1pm' do
  command 'curl -X POST http://localhost/api/d3d4b74ea38c163c820cd84b25f5/a8eecbf2d604ff6769fd64f1a491'
  command 'echo "Running cron at $(date)" >> /app/log/cron.log '
end
