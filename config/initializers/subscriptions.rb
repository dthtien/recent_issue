Rails.application.config.after_initialize do
  Users::Subscriber.subscribe
end
