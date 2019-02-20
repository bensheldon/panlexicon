# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Seeder do
  let(:seeder) { described_class.new }

  describe '#users' do
    it 'creates a user' do
      expect do
        seeder.users
      end.to change(User, :count).by(1)
    end
  end

  describe '#search_history' do
    use_moby_cats

    it 'creates search records' do
      expect do
        seeder.search_history(1)
      end.to change(SearchRecord, :count)
    end
  end
end
