# == Schema Information
#
# Table name: words
#
#  id   :integer          not null, primary key
#  name :string(255)      not null
#

class Word < ActiveRecord::Base
  attr_reader :search_group_count, :search_bucket
  has_and_belongs_to_many :groups, join_table: 'groupings'

  def search_group_count=(count)
    @search_group_count = count.to_i
  end

  def search_bucket=(bucket)
    @search_bucket = bucket.to_i
  end

end
