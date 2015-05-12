FROM debian/jessie
MAINTAINER Michele Bertasi

ENV RUST_VERSION=1.0.0-beta.4

# install pagkages
RUN apt-get update                                                                                  && \
    apt-get install -y --no-install-recommends build-essential                                         \
        ca-certificates curl git libssl-dev                                                         && \
# install rust binaries
    cd /tmp                                                                                         && \
    curl -sO https://static.rust-lang.org/dist/rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz   && \
    tar -xvzf rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz                                    && \
    ./rust-$RUST_VERSION-x86_64-unknown-linux-gnu/install.sh                                        && \
# source dir
    mkdir /source                                                                                   && \
# cleanup
    apt-get remove --purge -y curl                                                                  && \
    apt-get autoclean && apt-get clean                                                              && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/source"]
WORKDIR /source

CMD ["/bin/bash"]
