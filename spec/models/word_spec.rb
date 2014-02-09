require 'spec_helper'

describe Word do
  it "has a valid factory" do
    group = FactoryGirl.build :word
    expect(group).to be_valid
  end
end
