module MobyMacros
  def uses_moby_data
    before do
      path = Pathname('spec/fixtures/not_moby.txt')
      MobyImporter.new(path, print_log: true).import
    end
  end
end
