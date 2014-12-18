every [:monday , :wednesday, :friday],  :at => "4pm" do
  runner "MessageSenderWorker(Date.today)"
end
