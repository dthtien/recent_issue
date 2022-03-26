# frozen_string_literal: true

module Publishable
  extend ActiveSupport::Concern

  included do
    after_create_commit :publish_create
    after_update_commit :publish_update
    after_destroy_commit :publish_destroy
  end

  class_methods do
    def subscribe(event = :any, &block)
      event_name = event == :any ? /#{table_name}/ : "#{table_name}.#{event}"

      ActiveSupport::Notifications.subscribe(event_name, block)

      self
    end
  end

  private

  def publish_create
    publish(:create)
  end

  def publish_update
    publish(:update)
  end

  def publish_destroy
    publish(:destroy)
  end

  def publish(event)
    event_name = "#{self.class.table_name}.#{event}"

    ActiveSupport::Notifications.publish(event_name, event: event, model: self)
  end
end
