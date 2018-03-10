module MobyMacros
  def use_moby_cats
    before :each do
      path = Pathname('spec/fixtures/moby_cats_thesaurus.txt')
      MobyImporter.new.thesaurus(path)
    end
  end

  def use_moby_thesaurus
    before :each do
      path = Pathname('spec/fixtures/moby_thesaurus.txt')
      MobyImporter.new.thesaurus(path)
    end
  end
end
