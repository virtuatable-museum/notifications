module Decorators
  class Notification < Draper::Decorator
    def to_h
      return {
        id: object.id.to_s,
        type: object.type,
        data: object.data,
        read: object.read,
        created_at: object.created_at.utc.iso8601
      }
    end
  end
end