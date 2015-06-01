namespace :deploy do
  desc 'Deploys to the staging environment'
  task :staging do
    BeanstalkDeploy.new(:staging).deploy
    puts "Deployed to staging environment"
  end

  task :production do
    BeanstalkDeploy.new(:production).deploy
    puts "Deployed to staging environment"
  end
end
