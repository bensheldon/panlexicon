module MobyMacros
  def use_moby_cats
    before :each do
      path = Pathname('spec/fixtures/moby_cats.txt')
      MobyImporter.new(path, hide_log: true).import
    end
  end

  def use_moby_thesaurus
    before :each do
      path = Pathname('spec/fixtures/moby_thesaurus.txt')
      MobyImporter.new(path, hide_log: true).import
    end
  end
end
