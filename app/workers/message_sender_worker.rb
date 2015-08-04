class MessageSenderWorker
  include Sidekiq::Worker

  def perform(date, testing_mode = false)
    Rails.logger.info "TESTE CRON"
  end

end
