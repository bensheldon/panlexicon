require 'rails_helper'

RSpec.describe Word do
  it 'has a valid factory' do
    group = FactoryGirl.build :word
    expect(group).to be_valid
  end
end
