workflow "On Pull Request" {
  resolves = ["Add to Project Board"]
  on = "pull_request"
}

workflow "On Issue" {
  resolves = ["Add to Project Board"]
  on = "issues"
}

action "Add to Project Board" {
  uses = "bensheldon/action-add-to-project@master"
  secrets = ["GITHUB_TOKEN"]
  env = {
    COLUMN_ID = "2360744"
  }
}
