SolidQueueWeb::Engine.routes.draw do
  root "dashboard#index"
  
  get "jobs/:status", to: "jobs#index", as: :jobs_by_status, constraints: { status: /ready|in_progress|scheduled|recurring|failed|completed/ }
  get "queues", to: "queues#index"
  
  namespace :api do
    delete "jobs/:id", to: "jobs#destroy"
    post "jobs/:id/retry", to: "jobs#retry"
  end
end