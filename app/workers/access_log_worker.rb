class AccessLogWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 3

  def perform(access_attributes)
    Access.create(access_attributes)
  end
end