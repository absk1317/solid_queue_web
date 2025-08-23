module SolidQueueWeb
  class QueuesController < ApplicationController
    def index
      @queues = fetch_queue_statistics
      @statistics = JobStatistics.generate
    end

    private

    def fetch_queue_statistics
      SolidQueue::Job.group(:queue_name)
                     .group('CASE 
                              WHEN finished_at IS NOT NULL THEN "completed"
                              WHEN ready_executions.id IS NOT NULL THEN "ready"
                              WHEN claimed_executions.id IS NOT NULL THEN "in_progress"
                              WHEN scheduled_executions.id IS NOT NULL THEN "scheduled"
                              WHEN failed_executions.id IS NOT NULL THEN "failed"
                              ELSE "unknown"
                            END')
                     .left_joins(:ready_execution, :claimed_execution, :scheduled_execution, :failed_execution)
                     .count
    end
  end
end