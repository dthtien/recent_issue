module Users
  module Subscriber
    def subscribe
      User.subscribe(:create) do
        puts 'user created!'
      end

      User.subscribe(:update) do |_event, payload|
        puts "user #{payload[:model].name} updated!"
      end
    end

    module_function :subscribe
  end
end
