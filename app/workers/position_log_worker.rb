class PositionLogWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 3

  def perform(position_attributes)
    Position.create(position_attributes)
  end
end