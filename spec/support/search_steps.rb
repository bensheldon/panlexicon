module SearchSteps
  def search_for(words)
    fill_in 'Search', with: words
    click_button 'Search'
  end
end
