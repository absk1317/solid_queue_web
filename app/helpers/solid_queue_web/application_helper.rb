module SolidQueueWeb
  module ApplicationHelper
    def job_status(job)
      return 'completed' if job.finished_at.present?
      return 'ready' if job.ready_execution.present?
      return 'in_progress' if job.claimed_execution.present?
      return 'scheduled' if job.scheduled_execution.present?
      return 'failed' if job.failed_execution.present?
      'unknown'
    end

    def status_badge_class(status)
      case status.to_s
      when 'ready'
        'badge-info'
      when 'in_progress'
        'badge-warning'
      when 'scheduled'
        'badge-secondary'
      when 'recurring'
        'badge-primary'
      when 'failed'
        'badge-danger'
      when 'completed'
        'badge-success'
      else
        'badge-light'
      end
    end

    def format_job_arguments(arguments)
      return 'N/A' if arguments.blank?
      
      case arguments
      when Hash
        arguments.to_json
      when Array
        arguments.inspect
      else
        arguments.to_s
      end
    rescue
      'Invalid arguments'
    end

    def truncate_arguments(arguments, length = 100)
      formatted = format_job_arguments(arguments)
      formatted.length > length ? "#{formatted[0..length]}..." : formatted
    end
  end
end