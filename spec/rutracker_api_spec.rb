require 'rutracker_api'

describe 'Rutracker Api' do
  let(:tracker) { RutrackerApi.new('login', 'password') }

  describe '#search' do
    describe 'with valid params' do
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
end
