# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MailchimpController do
  describe '#after_subscribe' do
    it 'returns successful response' do
      get :after_subscribe
      expect(response).to have_http_status :ok
    end
  end

  describe '#after_confirm' do
    it 'returns successful response' do
      get :after_confirm
      expect(response).to have_http_status :ok
    end
  end
end
