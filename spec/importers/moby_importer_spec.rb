require 'spec_helper'

describe MobyImporter do
  let(:txt) { Pathname('spec/fixtures/moby_cats.txt') }
  let(:moby_importer) { MobyImporter.new(txt, hide_log: true) }

  it 'has a valid fixture' do
    expect(txt.exist?).to be true
  end

  it 'imports words' do
    expect { moby_importer.import }.to change { Word.count }.from(0).to(10)
  end

  it 'is idempotent' do
    moby_importer.import # Do it once first
    expect { moby_importer.import }.to_not change { Word.count }
  end

  it 'does not import empty characters e.g. ",,"' do
    moby_importer.import # Do it once first
    expect(Word.find_by_name '').to eq nil
  end

  describe "moby bug with 'cackle' keyword duplication" do
    # The moby thesaurus has a bug in which "cackle" is
    # keyworkd for two different groups. We'll combine them.

    let(:txt) { Pathname('spec/fixtures/moby_cackle_bug.txt') }

    it "only creates one 'cackle' group" do
      moby_importer.import
      expect(Group.count).to eq 1
    end

    it "combines cackle's words into a single group" do
      moby_importer.import
      words_names = Group.first.words.pluck(:name)
      expect(words_names).to match_array %w[cackle laugh guffaw]
    end
  end
end
