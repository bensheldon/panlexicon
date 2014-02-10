require 'spec_helper'

describe MobyImporter do
  let(:txt) { Pathname('spec/fixtures/not_moby.txt') }
  let(:moby_importer) { MobyImporter.new(txt, print_log: false) }

  it "has a valid fixture" do
    expect(txt.exist?).to be_true
  end

  it "imports words" do
    expect{moby_importer.import}.to change{Word.count}.from(0).to(6)
  end

  it "is idempotent" do
    moby_importer.import # Do it once first
    expect{moby_importer.import}.to_not change{Word.count}
  end

end
