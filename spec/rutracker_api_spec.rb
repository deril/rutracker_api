require 'rutracker_api'
describe "Rutracker Api" do
  before { @tracker = RutrackerApi.new('login', 'pass') }
  subject { @tracker }

  describe "#search" do
    describe "with invalid params" do
      xit "raise exeption with wrong search term" do
        expect{@tracker.search(term: "&8")}.to raise_error("Wrong search term")
      end
    end

    describe "with valid params" do

      xit "returns link with term" do
        expect( @tracker.search(term: "Super Man") ).to eq('http://rutracker.org/forum/tracker.php?nm=Super Man')
      end
      xit "returns link with category" do
        expect( @tracker.search(term: "Super Man", category: '2,5') )
          .to eq('http://rutracker.org/forum/tracker.php?nm=Super Man&f[]=2&f[]=5')
      end
      xit "returns link with order_by key" do
        expect( @tracker.search(term: "Super Man", order_by: 'name') )
          .to eq('http://rutracker.org/forum/tracker.php?nm=Super Man&o=2')
      end
      xit "returns link with sort_by key" do
        expect( @tracker.search(term: "Super Man", sort_by: 'asc') )
          .to eq('http://rutracker.org/forum/tracker.php?nm=Super Man&s=1')
      end

    end
  end
end
