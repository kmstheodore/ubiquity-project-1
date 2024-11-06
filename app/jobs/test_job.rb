class TestJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Rails.logger.info "Test job executed with args: #{args.inspect}"
  end
end
