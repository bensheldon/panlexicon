workflow "New workflow" {
  on = "pull_request"
  resolves = ["Default PR Project Board"]
}

action "Default PR Project Board" {
  uses = "./.github/actions/default_project"
  secrets = ["GITHUB_TOKEN"]
  env = {
    COLUMN_ID = "2360744"
  }
}
