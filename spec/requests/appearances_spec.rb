require 'rails_helper'

RSpec.describe 'Appearances', type: :request do
  before do
    Episode.create(number: 1, date: '1/11/99')
    Guest.create(name: 'Bruce McCulloch', occupation: 'actor')
  end

  describe 'POST /appearances' do
    context 'with valid data' do
      let(:appearance_params) do
        { episode_id: Episode.first.id, guest_id: Guest.first.id, rating: 5 }
      end

      it 'creates a new appearance' do
        expect { post '/appearances', params: appearance_params }.to change(
          Appearance,
          :count,
        ).by(1)
      end

      it 'returns the associated episode and guest data' do
        post '/appearances', params: appearance_params

        expect(response.body).to include_json(
          {
            id: a_kind_of(Integer),
            rating: 5,
            episode: {
              id: a_kind_of(Integer),
              date: '1/11/99',
              number: 1,
            },
            guest: {
              id: a_kind_of(Integer),
              name: 'Bruce McCulloch',
              occupation: 'actor',
            },
          },
        )
      end

      it 'returns a status code of 201 (created)' do
        post '/appearances', params: appearance_params

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid data' do
      let!(:invalid_appearance_params) do
        { rating: 500, episode_id: Episode.first.id, guest_id: Guest.first.id }
      end

      it 'does not create a new appearance' do
        expect {
          post '/appearances', params: invalid_appearance_params
        }.to change(Appearance, :count).by(0)
      end

      it 'returns the error messages' do
        post '/appearances', params: invalid_appearance_params

        expect(response.body).to include_json({ errors: a_kind_of(Array) })
      end

      it 'returns a status code of 422 (Unprocessable Entity)' do
        post '/appearances', params: invalid_appearance_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
