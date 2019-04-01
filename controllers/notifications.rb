module Controllers
  class Notifications < Arkaan::Utils::Controller

    load_errors_from __FILE__

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
        notification.read = !!params['read']
        notification.save
        halt 200, {message: 'updated', item: Decorators::Notification.decorate(notification).to_h}.to_json
      end
    end
  end
end