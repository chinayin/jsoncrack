variable "version" {
  default = ""
}

variable "repo" {
  default = ""
}

variable "registry" {
  default = "docker.io"
}

variable "repository" {
  default = "${registry}/${repo}"
}

function "platforms" {
  params = []
  result = ["linux/amd64", "linux/arm64"]
}

target "_all_platforms" {
  platforms = platforms()
}

group "default" {
  targets = ["json-crack"]
}

target "json-crack" {
  inherits = ["_all_platforms"]
  context  = "."
  tags     = [
    "${repository}:latest",
    "${repository}:${version}",
  ]
  args = {
    GITHUB_REPOSITORY = "${repo}"
  }

}