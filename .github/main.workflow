workflow "Add PRs to Project Board" {
  resolves = ["Add to Project Board"]
  on = "pull_request"
}

action "Add to Project Board" {
  uses = "bensheldon/action-add-to-project@master"
  secrets = ["GITHUB_TOKEN"]
  env = {
    COLUMN_ID = "2360744"
  }
}
