require 'rubygems'
require 'bundler'
Bundler.setup(:default)

event = JSON.parse(File.read(ENV['GITHUB_EVENT_PATH']))
puts event.inspect

client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
current_repo = Octokit::Repository.from_url(event["repository"]["html_url"])


projects = client.projects(current_repo)
put projects

# client.create_project_card(123495, content_id: 1, content_type: 'PullRequest')
#
