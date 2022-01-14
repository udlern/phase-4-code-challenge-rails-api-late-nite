require 'rails_helper'

RSpec.describe Appearance, type: :model do
  let(:episode) { Episode.create(number: 1, date: '1/11/99') }
  let(:guest) { Guest.create(name: 'Bruce McCulloch', occupation: 'actor') }

  describe 'relationships' do
    it 'can access the associated episode' do
      appearance =
        Appearance.create(guest_id: guest.id, episode_id: episode.id, rating: 5)

      expect(appearance.episode).to eq(episode)
    end

    it 'can access the associated guest' do
      appearance =
        Appearance.create(guest_id: guest.id, episode_id: episode.id, rating: 5)

      expect(appearance.guest).to eq(guest)
    end
  end

  describe 'validations' do
    it 'must have a rating between 1 and 5' do
      expect(
        Appearance.create(
          guest_id: guest.id,
          episode_id: episode.id,
          rating: 1,
        ),
      ).to be_valid
      expect(
        Appearance.create(
          guest_id: guest.id,
          episode_id: episode.id,
          rating: 3,
        ),
      ).to be_valid
      expect(
        Appearance.create(
          guest_id: guest.id,
          episode_id: episode.id,
          rating: 5,
        ),
      ).to be_valid
      expect(
        Appearance.create(
          guest_id: guest.id,
          episode_id: episode.id,
          rating: 0,
        ),
      ).to be_invalid
      expect(
        Appearance.create(
          guest_id: guest.id,
          episode_id: episode.id,
          rating: 6,
        ),
      ).to be_invalid
      expect(
        Appearance.create(guest_id: guest.id, episode_id: episode.id),
      ).to be_invalid
    end
  end
end
