# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AboutsController, type: :controller do
  render_views

  describe '#show' do
    it 'renders successfully' do
      get :show
      expect(response).to have_http_status :ok
    end
  end
end
