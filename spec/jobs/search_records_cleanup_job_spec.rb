# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SearchRecordsCleanupJob do
  describe '#perform' do
    it 'does not error' do
      job = described_class.new
      job.perform
    end
  end
end
