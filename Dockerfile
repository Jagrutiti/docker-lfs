FROM jenkins/jenkins:2.375.1

LABEL maintainer="mark.earl.waite@gmail.com"

USER root

# hadolint ignore=DL3008
RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends \
  gnupg \
  make \
  procps \
  wget \
  && rm -rf /var/lib/apt/lists/*

USER jenkins

# Check that expected utilities are available in the image
RUN test -x /usr/bin/pgrep
RUN test -x /usr/local/bin/git-lfs || test -x /usr/bin/git-lfs
RUN test -x /usr/bin/wget

# $REF (defaults to `/usr/share/jenkins/ref/`) contains all reference configuration we want
# to set on a fresh new installation. Use it to bundle additional plugins
# or config file with your custom jenkins Docker image.
COPY --chown=jenkins:jenkins ref /usr/share/jenkins/ref/

ENV CASC_JENKINS_CONFIG ${JENKINS_HOME}/configuration-as-code/
