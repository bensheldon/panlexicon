# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "db:seed:users", type: :rake do
  it 'creates users' do
    expect do
      task.invoke
    end.to change(User, :count)
  end
end
