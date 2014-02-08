require 'spec_helper'

describe Search do

  uses_moby_data

  let(:cat) { Term.find_by(name: 'cat') }
  let(:dog) { Term.find_by(name: 'dog') }
  let(:cat_group) { Group.find_by(key_term: cat)}
  let(:search) { Search.new [cat, dog] }

  describe "#intersect_gids" do
    it "returns an array of integers" do
      expect(search.intersect_gids[0]).to be_an(Integer)
    end

    it "returns the correct value" do
      expect(search.intersect_gids).to include cat_group.id
    end
  end
end
