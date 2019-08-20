# frozen_string_literal: true

module Controllers
  # Main controller providing routes to create or update notifications.
  # @author Vincent Courtois <courtois.vincent@outlook.com>
  class Notifications < Arkaan::Utils::Controllers::Checked
    load_errors_from __FILE__

    declare_status_route

    declare_route 'get', '/' do
      session = check_session('notifications_list')
      halt 200, Services::Notifications.instance.list(session, params).to_json
    end

    declare_route 'put', '/:id' do
      session = check_session('notification_update')
      notification = session.account.notifications.where(id: params['id']).first

      if notification.nil?
        custom_error 404, 'notification_update.notification_id.unknown'
      else
        notification.update_attribute(:read, params['read'])
        item = Decorators::Notification.decorate(notification).to_h
        halt 200, { message: 'updated', item: item }.to_json
      end
    end
  end
end
