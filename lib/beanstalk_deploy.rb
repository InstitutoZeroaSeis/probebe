require 'sshkit/dsl'

class BeanstalkDeploy
  BEANSTALK_ENVIRONMENTS = {
    staging: 'staging',
    production: 'production-docker'
  }
  FILES_TO_ZIP = [
    'Dockerrun.aws.json'
  ]
  S3_BUCKET = 'elasticbeanstalk-us-east-1-505000041159'

  def initialize(environment)
    @environment = environment
  end

  def deploy
    build_docker_image
    remove_existing_zip_file
    create_zip_file
    send_to_s3
    create_beanstalk_version
    deploy_to_beanstalk
  end

  protected

  def current_version
    `git rev-parse --short HEAD`.chomp
  end

  def current_version_file_name
    "deploy-#{@environment}-#{current_version}.zip"
  end

  def current_version_tmp_file_name
    "tmp/#{current_version_file_name}"
  end

  def current_message
    `git log -1 --pretty=%B`.chomp
  end

  def remove_existing_zip_file
    return unless File.exist?(current_version_tmp_file_name)
    FileUtils.rm(current_version_tmp_file_name)
  end

  def build_docker_image
    SSHKit::Backend::Netssh.configure do |ssh|
      ssh.ssh_options = {
        user: 'root',
        keys: %w(/app/ssh/probebe_build_rsa)
      }
    end

    git_root = '/root/pro-bebe'
    environment = BEANSTALK_ENVIRONMENTS[@environment]
    on '45.55.217.11' do
      within ('/root') do
        next if test("[ -d pro-bebe ]")
        execute('git clone git@bitbucket.org:myvizir/pro-bebe.git')
      end

      within('/root/pro-bebe') do
        execute("git -C #{git_root} pull")
        execute("#{git_root}/deploy/#{environment}/build.sh")
        execute("#{git_root}/deploy/#{environment}/deploy.sh")
      end
    end
  end

  def create_zip_file
    Zip::File.open(current_version_tmp_file_name, Zip::File::CREATE) do |file|
      FILES_TO_ZIP.each do |file_name|
        file.add(file_name, file_name)
      end
    end
  end

  def send_to_s3
    s3_client = AWS::S3.new
    s3_obj = s3_client.buckets[S3_BUCKET].objects[current_version_file_name]
    s3_obj.write(open(current_version_tmp_file_name))
  end

  def create_beanstalk_version
    beanstalk = AWS::ElasticBeanstalk.new
    beanstalk.client.create_application_version(
      application_name: 'probebe-docker',
      version_label: current_version,
      description: current_message,
      source_bundle: {
        s3_bucket: 'elasticbeanstalk-us-east-1-505000041159',
        s3_key: current_version_file_name
      })
  end

  def deploy_to_beanstalk
    beanstalk = AWS::ElasticBeanstalk.new
    beanstalk.client.update_environment(
      environment_name: @environment.to_s, version_label: current_version
    )
  end
end
