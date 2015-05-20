namespace :deploy do
  namespace :staging do
    desc 'Deploys to the staging environment'
    task :beanstalk do
      BeanstalkDeploy.new(:staging).deploy
      puts "Deploy started to the staging environment"
    end
  end
end
