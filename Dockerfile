FROM ubuntu:24.04

USER root

# Install CircleCI Registry and circleci-runner package
# Curl is needed for pulling the script while ca-certificates allow curl to pull using HTTPS
# Could also install gnupg debian-archive-keyring apt-transport-https but those are handled by install script
RUN apt-get update \
    && apt-get install --no-install-recommends -y curl ca-certificates \
    && curl -s https://packagecloud.io/install/repositories/circleci/runner/script.deb.sh?any=true -o /tmp/script.deb.sh \
    && bash /tmp/script.deb.sh \
    && rm -f /tmp/script.deb.sh \
    && apt-get install --no-install-recommends -y circleci-runner \
    && rm -rf /var/lib/apt/lists/*

USER circleci

CMD ["/usr/bin/circleci-runner", "machine", "-c", "/etc/circleci-runner/circleci-runner-config.yaml"]