# SolidQueueWeb

A clean, beautiful web interface for monitoring [Solid Queue](https://github.com/rails/solid_queue) background jobs. Built as a Rails engine for easy integration into any Rails application.

## Features

- 🎯 **Dashboard Overview**: Real-time statistics showing job counts across all statuses
- 📊 **Job Monitoring**: View jobs by status (Ready, In Progress, Scheduled, Recurring, Failed, Completed)
- 🔍 **Advanced Filtering**: Filter jobs by class name, queue, arguments, and status
- 🏷️ **Queue Management**: View job distribution across different queues
- 🛠️ **Job Actions**: Retry failed jobs and delete them when needed
- 🔐 **Optional Authentication**: HTTP Basic Auth support for security
- 🎨 **Responsive UI**: Clean, modern interface built with Bootstrap
- ⚡ **Zero Dependencies**: No external JavaScript frameworks required

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'solid_queue_web'
```

And then execute:

```bash
$ bundle install
```

Run the install generator:

```bash
$ rails generate solid_queue_web:install
```

This will:
- Create an initializer at `config/initializers/solid_queue_web.rb`
- Add the mount point to your routes
- Show setup instructions

## Usage

After installation, visit `http://localhost:3000/solid_queue` to access the dashboard.

### Configuration

Configure the gem in `config/initializers/solid_queue_web.rb`:

```ruby
SolidQueueWeb.configure do |config|
  # Number of jobs to display per page (default: 25)
  config.jobs_per_page = 25

  # HTTP Basic Authentication (optional)
  config.http_basic_auth_username = "admin"
  config.http_basic_auth_password = "your_secure_password"
end
```

### Custom Mount Path

You can customize the mount path in your `config/routes.rb`:

```ruby
mount SolidQueueWeb::Engine => "/admin/jobs"
# or
mount SolidQueueWeb::Engine => "/background_jobs"
```

### Authentication

For production environments, it's recommended to add authentication:

```ruby
# config/initializers/solid_queue_web.rb
SolidQueueWeb.configure do |config|
  config.http_basic_auth_username = ENV['SOLID_QUEUE_WEB_USERNAME']
  config.http_basic_auth_password = ENV['SOLID_QUEUE_WEB_PASSWORD']
end
```

Or integrate with your application's authentication system by overriding the authentication in your routes:

```ruby
# config/routes.rb
authenticate :user, lambda { |u| u.admin? } do
  mount SolidQueueWeb::Engine => "/solid_queue"
end
```

## Screenshots

The dashboard provides:

1. **Overview Page**: Statistics cards showing total jobs, ready, in progress, scheduled, recurring, failed, and completed jobs
2. **Job Lists**: Detailed tables showing individual jobs with their status, arguments, and creation time
3. **Filtering**: Search and filter jobs by class name, queue, or arguments
4. **Queue View**: Overview of job distribution across different queues

## Development

After checking out the repo, run `bundle install` to install dependencies.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/absk1317/solid_queue_web.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Compatibility

- Ruby 3.1.0+
- Rails 7.0.0+
- Solid Queue 0.1.0+

## Architecture

This gem is built as a Rails Engine, making it easy to mount in any Rails application. It follows these design principles:

- **Zero Dependencies**: Uses only Rails and Solid Queue, with Bootstrap CDN for styling
- **Clean Architecture**: Separate controllers, models, and views with clear responsibilities
- **Secure by Default**: Optional authentication with sensible defaults
- **Performance Focused**: Efficient queries with proper includes and limits
- **Mobile Responsive**: Works well on all screen sizes