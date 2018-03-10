module MobyMacros
  def use_moby_cats
    before :each do
      MobyImporter.new.thesaurus Pathname('spec/fixtures/moby_cats_thesaurus.txt')
      MobyImporter.new.parts_of_speech Pathname('spec/fixtures/moby_cats_parts_of_speech.txt')
    end
  end

  def use_moby_thesaurus
    before :each do
      path = Pathname('spec/fixtures/moby_thesaurus.txt')
      MobyImporter.new.thesaurus(path)
    end
  end
end
