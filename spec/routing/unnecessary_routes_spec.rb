require 'rails_helper'

RSpec.describe 'UnnecessaryRoutes', type: :routing do
  it 'does not define unnecessary guest routes' do
    expect(post: '/guests').not_to be_routable
    expect(get: '/guests/1').not_to be_routable
    expect(patch: '/guests/1').not_to be_routable
    expect(delete: '/guests/1').not_to be_routable
  end

  it 'does not define unnecessary episode routes' do
    expect(post: '/episodes').not_to be_routable
    expect(patch: '/episodes/1').not_to be_routable
  end

  it 'does not define unnecessary appearance routes' do
    expect(get: '/appearances').not_to be_routable
    expect(get: '/appearances/1').not_to be_routable
    expect(patch: '/appearances/1').not_to be_routable
    expect(delete: '/appearances/1').not_to be_routable
  end
end
