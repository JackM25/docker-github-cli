FROM ubuntu:22.04

ARG GH_CLI_VERSION

# CURL and WGET
RUN apt-get update && apt-get install -y curl wget jq

# GitHub CLI
RUN wget https://github.com/cli/cli/releases/download/v${GH_CLI_VERSION}/gh_${GH_CLI_VERSION}_linux_amd64.tar.gz && \
        tar xvzf gh_${GH_CLI_VERSION}_linux_amd64.tar.gz && \
        mv /gh_${GH_CLI_VERSION}_linux_amd64/bin/gh /bin/gh && \
        rm gh_${GH_CLI_VERSION}_linux_amd64.tar.gz && \
        rm -r /gh_${GH_CLI_VERSION}_linux_amd64


CMD ["gh"]