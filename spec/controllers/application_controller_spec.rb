# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe "#human_request? / #bot_request?" do
    controller do
      def index
        render html: "ok"
      end
    end

    context 'when browser-looking user agent' do
      it "is determines whether it is a bot or human user agent" do
        request.env['HTTP_USER_AGENT'] = 'Chrome'
        get :index
        expect(controller.human_request?).to be true
        expect(controller.bot_request?).to be false
      end
    end

    context 'when bot-looking user agent' do
      it "is determines whether it is a bot or human user agent" do
        request.env['HTTP_USER_AGENT'] = 'googlebot'
        get :index
        expect(controller.human_request?).to be false
        expect(controller.bot_request?).to be true
      end
    end
  end
end
