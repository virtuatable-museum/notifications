RSpec.describe Controllers::Notifications do

  let!(:account) { create(:account) }
  let!(:gateway) { create(:gateway) }
  let!(:appli) { create(:application, creator: account) }
  let!(:session) { create(:session, account: account) }

  def app
    Controllers::Notifications.new
  end

  # rspec spec/controllers/notifications_spec.rb[1:1]
  include_examples 'GET /'

  # rspec spec/controllers/notifications_spec.rb[1:2]
  include_examples 'PUT /:id'
end