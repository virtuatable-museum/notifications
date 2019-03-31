RSpec.shared_examples 'GET /' do
  describe 'GET /' do

    describe 'Nominal case' do
      let!(:notif_1) { create(:notification, type: 'T1', data: {foo: 'D1'}, account: account) }
      let!(:notif_2) { create(:notification, type: 'T2', data: {bar: 'D2'}, account: account) }

      before do
        get '/', {token: gateway.token, app_key: appli.key, session_id: session.token}
      end
      it 'returns a OK (200) status code' do
        expect(last_response.status).to be 200
      end
      it 'returns the correct body' do
        expect(last_response.body).to include_json([
          {
            type: 'T2',
            data: {bar: 'D2'},
            created_at: notif_2.created_at.utc.iso8601
          },
          {
            type: 'T1',
            data: {foo: 'D1'},
            created_at: notif_1.created_at.utc.iso8601
          }
        ])
      end
    end

    describe 'filtering attributes' do
      let!(:notif_1) { create(:notification, type: 'T1', data: {foo: 'D1'}, account: account, created_at: DateTime.yesterday) }
      let!(:notif_2) { create(:notification, type: 'T2', data: {bar: 'D2'}, account: account, created_at: DateTime.now) }

      describe ':skip attribute' do
        before do
          get '/', {token: gateway.token, app_key: appli.key, session_id: session.token, skip: 1}
        end
        it 'returns a OK (200) status code' do
          expect(last_response.status).to be 200
        end
        it 'returns the right number of notifications' do
          expect(JSON.parse(last_response.body).count).to be 1
        end
        it 'returns the correct body' do
          expect(last_response.body).to include_json([
            {
              type: 'T1',
              data: {foo: 'D1'},
              created_at: notif_1.created_at.utc.iso8601
            }
          ])
        end
      end

      describe ':limit attribute' do
        before do
          get '/', {token: gateway.token, app_key: appli.key, session_id: session.token, limit: 1}
        end
        it 'returns a OK (200) status code' do
          expect(last_response.status).to be 200
        end
        it 'returns the right number of notifications' do
          expect(JSON.parse(last_response.body).count).to be 1
        end
        it 'returns the correct body' do
          expect(last_response.body).to include_json([
            {
              type: 'T2',
              data: {bar: 'D2'},
              created_at: notif_2.created_at.utc.iso8601
            }
          ])
        end
      end
    end

    it_should_behave_like 'a route', 'get', '/notifications'

    describe '400 errors' do
      describe 'when the session ID is not found' do
        before do
          get '/', {token: gateway.token, app_key: appli.key}
        end
        it 'returns a Bad Request (400) status code' do
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
      describe 'when the session ID is not found' do
        before do
          get '/', {token: gateway.token, app_key: appli.key, session_id: 'unknown'}
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
    end
  end
end