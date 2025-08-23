module SolidQueueWeb
  class DashboardController < ApplicationController
    def index
      @statistics = JobStatistics.generate
      @recent_jobs = fetch_recent_jobs
    end

    private

    def fetch_recent_jobs
      SolidQueue::Job.includes(:ready_execution, :claimed_execution, :failed_execution, :scheduled_execution)
                    .order(created_at: :desc)
                    .limit(10)
    end
  end
end