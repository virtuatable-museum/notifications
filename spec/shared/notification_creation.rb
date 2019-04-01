RSpec.shared_examples 'PUT /:id' do

  let!(:update_account) { create(:account) }
  let!(:update_session) { create(:session, account: update_account) }
  let!(:notification) { create(:notification, type: 'NOTIFICATION.TEST', read: false, account: update_account) }

  describe 'PUT /:id' do
    describe 'Nominal case' do
      before do
        put "/notifications/#{notification.id}", {token: gateway.token, app_key: appli.key, session_id: update_session.token, read: true}
      end
      it 'returns a OK (200) status code' do
        expect(last_response.status).to be 200
      end
      it 'returns the correct body' do
        expect(last_response.body).to include_json({
          message: 'updated',
          item: {
            id: notification.id.to_s,
            read: true,
            type: 'NOTIFICATION.TEST',
            data: {}
          }
        })
      end
      it 'has correctly updated the notification' do
        notification.reload
        expect(notification.read).to be true
      end
    end

    it_should_behave_like 'a route', 'put', '/notifications/notification_id'

    describe '400 errors' do
      describe 'When the session ID is not given' do
        before do
          put "/notifications/#{notification.id}", {token: gateway.token, app_key: appli.key, read: true}
        end
        it 'returns a Bad request (400) status code' do
          expect(last_response.status).to be 400
        end
        it 'returns the correct body' do
          expect(last_response.body).to include_json({
            status: 400,
            field: 'session_id',
            error: 'required'
          })
        end
      end
    end
    describe '404 errors' do
      describe 'When the session Id is not found' do
        before do
          put "/notifications/#{notification.id}", {token: gateway.token, app_key: appli.key, session_id: 'unknown', read: true}
        end
        it 'returns a Not Found (404) status code' do
          expect(last_response.status).to be 404
        end
        it 'returns the correct body' do
          expect(last_response.body).to include_json({
            status: 404,
            field: 'session_id',
            error: 'unknown'
          })
        end
      end
      describe 'When the notification is not found' do
        before do
          put "/notifications/unknown", {token: gateway.token, app_key: appli.key, session_id: update_session.token, read: true}
        end
        it 'returns a Not Found (404) status code' do
          expect(last_response.status).to be 404
        end
        it 'returns the correct body' do
          expect(last_response.body).to include_json({
            status: 404,
            field: 'notification_id',
            error: 'unknown'
          })
        end
      end
    end
  end
end