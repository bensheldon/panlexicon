require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem "json", "~> 2.2.0"
  gem "octokit", "~> 4.14.0"
end

GITHUB_TOKEN = ENV.fetch('GITHUB_TOKEN')
COLUMN_ID = ENV.fetch('COLUMN_ID')

event_json = File.read(ENV['GITHUB_EVENT_PATH'])
event = JSON.parse(event_json)

client = Octokit::Client.new(access_token: GITHUB_TOKEN)
# current_repo = Octokit::Repository.from_url(event["repository"]["html_url"])

# projects = client.projects(current_repo, accept: "application/vnd.github.inertia-preview+json")
# puts projects.inspect

if event['pull_request'] && ['opened', 'synchronize'].include?(event['action'])
  content_id = event['pull_request']['id']
  client.create_project_card(COLUMN_ID, content_id: content_id, content_type: 'PullRequest', accept: "application/vnd.github.inertia-preview+json")
end


