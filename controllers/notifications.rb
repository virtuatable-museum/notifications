module Controllers
  class Notifications < Arkaan::Utils::Controller

    load_errors_from __FILE__

    get '/' do
      session = check_session('notifications_list')

      halt 200, Services::Notifications.instance.list(session, params).to_json
    end
  end
end