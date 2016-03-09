require 'rails_helper'

RSpec.describe ProBebeConfig, type: :model do
  before do
    @app_config_hash = {
      "message_delivery" => {
        "deliver_sms" => true,
        "wsdl_url" => "http://sms.example.com",
        "wsdl_end_point" => "http://sms.example.com/endpoint",
        "wsdl_name_space" => "http://namespace.example.com",
        "spring_user" => "user",
        "spring_password" => "password",
        "elasticsearch" => {host: 'elasticsearch:9200'}
      }
    }
    stub_const "ProBebeConfig::APP_CONFIG", @app_config_hash
  end

  subject { ProBebeConfig }

  its(:deliver_sms?) { should eq(@app_config_hash["message_delivery"]["deliver_sms"]) }
  its(:wsdl_url) { should eq(@app_config_hash["message_delivery"]["wsdl_url"]) }
  its(:wsdl_end_point) { should eq(@app_config_hash["message_delivery"]["wsdl_end_point"]) }
  its(:wsdl_name_space) { should eq(@app_config_hash["message_delivery"]["wsdl_name_space"]) }
  its(:spring_user) { should eq(@app_config_hash["message_delivery"]["spring_user"]) }
  its(:spring_password) { should eq(@app_config_hash["message_delivery"]["spring_password"]) }
  its(:elasticsearch_host) { should eq(@app_config_hash["message_delivery"]["elasticsearch"]["host"]) }
end
