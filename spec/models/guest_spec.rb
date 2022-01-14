require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'relationships' do
    let(:episode) { Episode.create(number: 1, date: '1/11/99') }
    let(:guest) { Guest.create(name: 'Bruce McCulloch', occupation: 'actor') }

    it 'can access the associated appearances' do
      appearance =
        Appearance.create(guest_id: guest.id, episode_id: episode.id, rating: 5)

      expect(guest.appearances).to include(appearance)
    end

    it 'can access the associated episodes' do
      Appearance.create(guest_id: guest.id, episode_id: episode.id, rating: 5)

      expect(guest.episodes).to include(episode)
    end
  end
end
