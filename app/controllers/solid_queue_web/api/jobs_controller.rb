module SolidQueueWeb
  module Api
    class JobsController < ApplicationController
      def destroy
        job = SolidQueue::Job.find(params[:id])
        
        if job.failed_execution
          job.failed_execution.destroy
          render json: { status: 'success', message: 'Failed job deleted successfully' }
        else
          render json: { status: 'error', message: 'Job not found or not failed' }, status: :not_found
        end
      rescue ActiveRecord::RecordNotFound
        render json: { status: 'error', message: 'Job not found' }, status: :not_found
      rescue => e
        render json: { status: 'error', message: e.message }, status: :internal_server_error
      end

      def retry
        job = SolidQueue::Job.find(params[:id])
        
        if job.failed_execution
          # Create a new ready execution for retry
          job.failed_execution.destroy
          SolidQueue::ReadyExecution.create!(
            job: job,
            queue_name: job.queue_name,
            priority: job.priority
          )
          render json: { status: 'success', message: 'Job retried successfully' }
        else
          render json: { status: 'error', message: 'Job not found or not failed' }, status: :not_found
        end
      rescue ActiveRecord::RecordNotFound
        render json: { status: 'error', message: 'Job not found' }, status: :not_found
      rescue => e
        render json: { status: 'error', message: e.message }, status: :internal_server_error
      end
    end
  end
end