module SolidQueueWeb
  class JobsController < ApplicationController
    def index
      @status = params[:status]
      @jobs = fetch_jobs_by_status(@status)
      @statistics = JobStatistics.generate
    end

    private

    def fetch_jobs_by_status(status)
      base_scope = case status
      when 'ready'
        scope = SolidQueue::ReadyExecution.includes(:job)
        apply_filters(scope, :job)
      when 'in_progress'
        scope = SolidQueue::ClaimedExecution.includes(:job)
        apply_filters(scope, :job)
      when 'scheduled'
        scope = SolidQueue::ScheduledExecution.includes(:job)
        apply_filters(scope, :job)
      when 'recurring'
        apply_filters(SolidQueue::RecurringTask, nil)
      when 'failed'
        scope = SolidQueue::FailedExecution.includes(:job)
        apply_filters(scope, :job)
      when 'completed'
        scope = SolidQueue::Job.where.not(finished_at: nil)
        apply_filters(scope, nil)
      else
        scope = SolidQueue::Job.includes(:ready_execution, :claimed_execution, :failed_execution, :scheduled_execution)
        apply_filters(scope, nil)
      end

      base_scope.order(created_at: :desc).limit(SolidQueueWeb.jobs_per_page)
    end

    def apply_filters(scope, job_association)
      # Apply job class filter
      if params[:job_class].present?
        if job_association
          scope = scope.joins(job_association).where("solid_queue_jobs.class_name ILIKE ?", "%#{params[:job_class]}%")
        else
          scope = scope.where("class_name ILIKE ?", "%#{params[:job_class]}%") if scope.respond_to?(:where)
        end
      end

      # Apply queue filter
      if params[:queue].present?
        if job_association
          scope = scope.joins(job_association).where("solid_queue_jobs.queue_name ILIKE ?", "%#{params[:queue]}%")
        else
          scope = scope.where("queue_name ILIKE ?", "%#{params[:queue]}%") if scope.respond_to?(:where)
        end
      end

      # Apply arguments filter
      if params[:arguments].present?
        if job_association
          scope = scope.joins(job_association).where("solid_queue_jobs.arguments::text ILIKE ?", "%#{params[:arguments]}%")
        else
          scope = scope.where("arguments::text ILIKE ?", "%#{params[:arguments]}%") if scope.respond_to?(:where)
        end
      end

      scope
    end
  end
end