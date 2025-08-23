module SolidQueueWeb
  class JobStatistics
    def self.generate
      {
        total: SolidQueue::Job.count,
        ready: SolidQueue::ReadyExecution.count,
        in_progress: SolidQueue::ClaimedExecution.count,
        scheduled: SolidQueue::ScheduledExecution.count,
        recurring: SolidQueue::RecurringTask.count,
        failed: SolidQueue::FailedExecution.count,
        completed: SolidQueue::Job.where.not(finished_at: nil).count
      }
    end
  end
end