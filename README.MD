# Unofficial GitHub CLI Docker Image

![GitHub issues](https://img.shields.io/github/issues-raw/jackm25/docker-github-cli)

Unofficial GitHub CLI Docker Image, containing the GitHub CLI tool and other related tools.

## What is GitHub CLI?

GitHub CLI (`gh`) is GitHub on the command line. It brings pull requests, issues, and other GitHub concepts to the terminal, providing a command line interface to many GitHub actions.

See: https://github.com/cli/cli

## About the Image
This image is primarily designed for use in CI/CD pipelines and development workflows, so is intentionally lightweight.

However, in addition to `gh`, the image also includes:
*  `curl`
*  `gzip`
*  `tar`
*  `wget`
*  `jq`

## Image Variants

* `github-cli:latest`, `github-cli:latest-alpine`: The latest supported version of GitHub CLI, running in an Alpine based container.
* `github-cli:latest-ubuntu`: The latest supported version of GitHub CLI, running in an Ubuntu based container.
* `github-cli:<version>`, `github-cli:<version>-alpine`: The given version of GitHub CLI, running in an Alpine based container. Note that only a subset of versions are currently supported.
* `github-cli:<version>-ubuntu`: The given version of GitHub CLI, running in an Ubuntu based container. Note that only a subset of versions are currently supported.

You can find the full list of image variants and supported versions here: [JackM25/github-cli/versions](https://github.com/JackM25/docker-github-cli/pkgs/container/github-cli/versions)

## How to use the Image
### From the Command Line
`gh` commands can be run inside the image directly from the command line.

```bash
docker pull ghcr.io/jackm25/github-cli:<IMAGE_TAG>

# Open a shell inside the container
docker run -it ghcr.io/jackm25/github-cli:<IMAGE_TAG> sh

# gh commands can now be run from inside the container
gh ...
```

You can find the full list of `gh` commands here: https://cli.github.com/manual/gh 

### As Part of a CI/CD Pipeline
To use the image as part of a CI/CD pipeline. Set the image as the container in which steps are run as part of your pipeline.

Then ensure `GH_TOKEN` is set in the `env` for that pipeline. GitHub CLI will use this token to authenticate with GitHub.

For example, in CircleCI:
```yaml
version: 2.1
executors:
  gh-cli-docker:
    docker:
      - image: ghcr.io/jackm25/github-cli:<IMAGE_TAG>
    resource_class: small

jobs:
  gh-example:
    executor: gh-cli-docker
    steps:
      - run:
          name: Run gh Command
          command: gh ...

workflows:
  run-gh-example:
     jobs:
      - gh-example:
          context: gh-creds # Context containing GH_TOKEN
```

### As a Base Image in Your Dockerfile
This image can also be used as a base image in your own dockerfile.

```dockerfile
FROM ghcr.io/jackm25/github-cli:<IMAGE_TAG>

# Your dockerfile commands here...
```

## Contributing
### Building Locally
The image can be built locally as follows:
```bash
# From the directory for the given base image
cd alpine # or cd ubuntu for the ubuntu based image

# Build the image, where <version> is the version of GitHub CLI to install
docker build --build-arg GH_CLI_VERSION=<version> . -t <image>:<tag>
```
For example: `docker build --build-arg GH_CLI_VERSION=2.14.3 . -t github-cli:2.14.3`

### Running Tests Locally
Once you have built the image, there are a minimal set of tests that can be run against it. These can be run as follows:
```bash
# From the directory for the given base image
cd alpine # or cd ubuntu for the ubuntu based image

# Test the image, where <image>:<tag> is the name and tag of the image to test
./test-image.sh <image>:<tag>
```

## License
Licensed under the MIT License