# frozen_string_literal: true

module MobyMacros
  def use_moby_cats_thesuarus
    before { MobyImporter.new.thesaurus Pathname('spec/fixtures/moby_cats_thesaurus.txt') }
  end

  def use_moby_cats_parts_of_speech
    before { MobyImporter.new.parts_of_speech Pathname('spec/fixtures/moby_cats_parts_of_speech.txt') }
  end

  def use_moby_cats
    use_moby_cats_thesuarus
    use_moby_cats_parts_of_speech
  end

  def use_moby_thesaurus
    before do
      path = Pathname('spec/fixtures/moby_thesaurus.txt')
      MobyImporter.new.thesaurus(path)
    end
  end
end

RSpec.configure do |config|
  config.extend(MobyMacros)
end
