require 'rails_helper'

RSpec.describe 'Guests', type: :request do
  before do
    Guest.create(name: 'Bruce McCulloch', occupation: 'actor')
    Guest.create(name: 'Mark McKinney', occupation: 'actor')
  end

  describe 'GET /guests' do
    it 'returns an array of all guests' do
      get '/guests'

      expect(response.body).to include_json(
        [
          {
            id: a_kind_of(Integer),
            name: 'Bruce McCulloch',
            occupation: 'actor',
          },
          {
            id: a_kind_of(Integer),
            name: 'Mark McKinney',
            occupation: 'actor',
          },
        ],
      )
    end

    it 'returns a status of 200 (OK)' do
      get '/guests'

      expect(response).to have_http_status(:ok)
    end
  end
end
