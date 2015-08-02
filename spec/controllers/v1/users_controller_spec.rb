require 'rails_helper'

describe V1::UsersController do
  describe '#show' do
    context 'When asking for the user info' do
      context 'when the user is created' do
        let!(:user) { User.create(device_token: 'MyToken')}
        before :each do
          @request.headers['TOKEN'] = user.device_token
          get :show
        end
        it 'returns http success' do
          expect(response.status).to eq 200
        end
      end
      context 'when the user is not created' do
        before :each do
          @request.headers['TOKEN'] = 'NewUserToken'
          get :show
        end
        it 'returns http success' do
          expect(response.status).to eq 200
        end
      end
    end
  end
end