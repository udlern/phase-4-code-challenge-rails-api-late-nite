require 'rails_helper'

RSpec.describe 'episodes', type: :request do
  before do
    e1 = Episode.create(number: 1, date: '1/11/99')
    e2 = Episode.create(number: 2, date: '1/12/99')
    g1 = Guest.create(name: 'Bruce McCulloch', occupation: 'actor')
    g2 = Guest.create(name: 'Mark McKinney', occupation: 'actor')

    Appearance.create(guest_id: g1.id, episode_id: e1.id, rating: 5)
    Appearance.create(guest_id: g2.id, episode_id: e1.id, rating: 4)
    Appearance.create(guest_id: g1.id, episode_id: e2.id, rating: 3)
  end

  describe 'GET /episodes' do
    it 'returns an array of all episodes' do
      get '/episodes'

      expect(response.body).to include_json(
        [
          { id: a_kind_of(Integer), date: '1/11/99', number: 1 },
          { id: a_kind_of(Integer), date: '1/12/99', number: 2 },
        ],
      )
    end

    it 'does not return any nested guestss' do
      get '/episodes'

      expect(response.body).not_to include_json([{ guests: a_kind_of(Array) }])
    end

    it 'returns a status of 200 (OK)' do
      get '/episodes'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /episodes/:id' do
    context 'with a valid ID' do
      it 'returns the matching episode with its associated guests' do
        get "/episodes/#{Episode.first.id}"

        expect(response.body).to include_json(
          {
            id: a_kind_of(Integer),
            date: '1/11/99',
            number: 1,
            guests: [
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
          },
        )
      end

      it 'returns a status of 200 (OK)' do
        get "/episodes/#{Episode.first.id}"

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with an invalid ID' do
      it 'returns an error message' do
        get '/episodes/bad_id'

        expect(response.body).to include_json({ error: 'Episode not found' })
      end

      it 'returns the appropriate HTTP status code' do
        get '/episodes/bad_id'

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /episodes/:id' do
    context 'with a valid ID' do
      it 'deletes the episode' do
        expect { delete "/episodes/#{Episode.first.id}" }.to change(
          Episode,
          :count,
        ).by(-1)
      end

      it 'deletes the associated appearances' do
        expect { delete "/episodes/#{Episode.first.id}" }.to change(
          Appearance,
          :count,
        ).by(-2)
      end
    end

    context 'with an invalid ID' do
      it 'returns an error message' do
        delete '/episodes/bad_id'

        expect(response.body).to include_json({ error: 'Episode not found' })
      end

      it 'returns the appropriate HTTP status code' do
        delete '/episodes/bad_id'

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
