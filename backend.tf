terraform {
  backend "remote" {
    organization = "sikademo"
    workspaces {
      name = "example-2021-01-15"
    }
  }
}
