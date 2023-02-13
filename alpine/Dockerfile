FROM alpine:3.17

ARG GH_CLI_VERSION

# GitHub CLI
RUN wget https://github.com/cli/cli/releases/download/v${GH_CLI_VERSION}/gh_${GH_CLI_VERSION}_linux_amd64.tar.gz && \
        tar xvzf gh_${GH_CLI_VERSION}_linux_amd64.tar.gz && \
        mv /gh_${GH_CLI_VERSION}_linux_amd64/bin/gh /bin/gh && \
        rm gh_${GH_CLI_VERSION}_linux_amd64.tar.gz && \
        rm -r /gh_${GH_CLI_VERSION}_linux_amd64

# CURL
RUN apk add curl jq

CMD ["gh"]