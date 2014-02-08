require 'spec_helper'

describe Term do
  it "has a valid factory" do
    group = FactoryGirl.build :term
    expect(group).to be_valid
  end
end
