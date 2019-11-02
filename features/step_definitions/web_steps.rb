
Given(/^I am on the Google homepage$/) do
  visit 'https://www.google.com'
end

When(/^I search for "(.*?)"$/) do |search_query|
  fill_in('q', :with => search_query)
end

Then(/^I should see the search results$/) do
  with_scope('div#main') do
    page.should have_content('sinatra-cucumber')
    page.should have_content('cucumber-sinatra')
    page.should have_content('Github')
  end
end