Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:5000' # Replace with your React app's origin, or '*' for any origin (not recommended for production)
    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             credentials: true # If you need to send cookies or authorization headers
  end
end