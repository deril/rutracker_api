require 'rutracker_api'
describe "Rutracker Api" do
  before { @tracker = RutrackerApi.new }
  subject { @tracker }

  describe "#search" do
    describe "with invalid params" do
      it "raise exeption with wrong search term" do
        expect{@tracker.search("&8")}.to raise_error("Wrong search term")
      end
    end

    describe "with valid params" do

      it "returns link with term" do
        expect( @tracker.search("Super Man") ).to eq('http://rutracker.org/forum/tracker.php?nm=Super Man')
      end
      it "returns link with category" do
        expect( @tracker.search("Super Man", {category: '2,5'}) )
          .to eq('http://rutracker.org/forum/tracker.php?nm=Super Man&f[]=2&f[]=5')
      end
      it "returns link with order_by key" do
        expect( @tracker.search("Super Man", {order_by: 'name'}) )
          .to eq('http://rutracker.org/forum/tracker.php?nm=Super Man&o=2')
      end
      it "returns link with sort_by key" do
        expect( @tracker.search("Super Man", {sort_by: 'asc'}) )
          .to eq('http://rutracker.org/forum/tracker.php?nm=Super Man&s=1')
      end

    end
  end
end
