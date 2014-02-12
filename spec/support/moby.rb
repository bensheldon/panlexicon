module MobyMacros
  def use_moby_cats
    before do
      path = Pathname('spec/fixtures/moby_cats.txt')
      MobyImporter.new(path, print_log: true).import
    end
  end
end
