require 'spec_helper'

describe Group do
  let(:group){ FactoryGirl.build :group }

  it "has a valid factory" do
    group = FactoryGirl.build :group
    expect(group).to be_valid
  end

  it "requires a key_term" do
    group = FactoryGirl.build :group, key_term: nil
    expect(group).to_not be_valid
  end

  it "has many terms" do
    term_1 = FactoryGirl.create :term
    term_2 = FactoryGirl.create :term

    group.terms += [term_1, term_2]
  end

end
