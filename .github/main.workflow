workflow "On Pull Request" {
  resolves = ["Add PR to Project Board"]
  on = "pull_request"
}

action "Add PR to Project Board" {
  uses = "bensheldon/action-add-to-project@master"
  secrets = ["GITHUB_TOKEN"]
  env = {
    COLUMN_ID = "2360744"
  }
}

workflow "On Issue" {
  resolves = ["Add Issue to Project Board"]
  on = "issue"
}

action "Add Issue to Project Board" {
  uses = "bensheldon/action-add-to-project@master"
  secrets = ["GITHUB_TOKEN"]
  env = {
    COLUMN_ID = "2360744"
  }
}

