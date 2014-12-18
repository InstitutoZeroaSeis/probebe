every 1.minute do
  runner "MessageSenderWorker.perform_async(Date.today)"
end
