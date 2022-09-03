# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SearchRecordsCleanupJob do
  around do |example|
    ApplicationRecord.set_statement_timeout(1) do
      example.run
    end
  end

  describe '#perform' do
    it 'does not error' do
      job = described_class.new
      job.perform
    end
  end
end
