# frozen_string_literal: true

module Decorators
  # Decorator for a notification, wrapping it into a hash.
  # @author Vincent Courtois <courtois.vincent@outlook.com>
  class Notification < Draper::Decorator
    def to_h
      {
        id: object.id.to_s,
        type: object.type,
        data: object.data,
        read: object.read,
        created_at: object.created_at.utc.iso8601
      }
    end
  end
end
