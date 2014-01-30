require 'spec_helper'

describe Group do

  it "has a valid factory" do
    group = FactoryGirl.build :group
    expect(group).to be_valid
  end

  it "requires a key_term" do
    group = FactoryGirl.build :group, key_term: nil
    expect(group).to_not be_valid
  end

end
