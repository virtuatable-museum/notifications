# frozen_string_literal: true

module Services
  # Service to get the notifications linked to a connected player.
  # @author Vincent Courtois <courtois.vincent@outlook.com>
  class Notifications
    include Singleton

    # Gets the sorted and filtered list of notifications for the given session.
    # @param session [Arkaan::Authentication::Session] the player's session.
    # @return [Array<Arkaan::Notification>] the notifications of the player.
    def list(session, parameters)
      notifications = sorted_notifications(session)
      if parameters.key?('skip')
        notifications = notifications.skip(parameters['skip'].to_i)
      end
      if parameters.key?('limit')
        notifications = notifications.limit(parameters['limit'].to_i)
      end
      notifications.to_a.map do |notification|
        Decorators::Notification.decorate(notification).to_h
      end
    end

    private

    def sorted_notifications(session)
      session.account.notifications.order_by(created_at: :desc)
    end
  end
end
