class MessageSenderWorker
  include Sidekiq::Worker

  def perform(date, testing_mode = false)
    Rails.logger.info "WORKER - Cron test"
  end

end
