require 'spec_helper'

RSpec.describe 'RutrackerApi' do
  it 'has a version number' do
    expect(RutrackerApi::VERSION).not_to be nil
  end

  let(:tracker) { RutrackerApi::Client.new('login', 'password') }

  before do
    # skip actual login for testing
    allow_any_instance_of(RutrackerApi::Client).to receive(:login)
  end

  describe '#prepare_query_string' do
    it 'returns link with term' do
      expect(tracker.send(:prepare_query_string, term: 'Super Man'))
        .to eq('https://rutracker.org/forum/tracker.php?nm=Super Man')
    end
    it 'returns link with category' do
      expect(tracker.send(:prepare_query_string, term: 'Super Man', category: '2,5'))
        .to eq('https://rutracker.org/forum/tracker.php?nm=Super Man&f=2,5')
    end
    it 'returns link with order_by key' do
      expect(tracker.send(:prepare_query_string, term: 'Super Man', order_by: :name))
        .to eq('https://rutracker.org/forum/tracker.php?nm=Super Man&o=2')
    end
    it 'returns link with sort_by key' do
      expect(tracker.send(:prepare_query_string, term: 'Super Man', sort: :asc))
        .to eq('https://rutracker.org/forum/tracker.php?nm=Super Man&s=1')
    end
  end
end
