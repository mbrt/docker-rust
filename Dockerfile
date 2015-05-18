FROM debian:jessie
MAINTAINER Michele Bertasi

ENV RUST_VERSION=1.0.0

# install pagkages
RUN apt-get update                                                                                  && \
    apt-get install -y --no-install-recommends build-essential curl ca-certificates git gdb         && \
# install rust binaries
    cd /tmp                                                                                         && \
    curl -sO https://static.rust-lang.org/dist/rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz   && \
    tar -xvzf rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz                                    && \
    ./rust-$RUST_VERSION-x86_64-unknown-linux-gnu/install.sh                                        && \
# install rust sources
    curl -sO https://static.rust-lang.org/dist/rustc-$RUST_VERSION-src.tar.gz                       && \
    tar -xvzf rustc-$RUST_VERSION-src.tar.gz                                                        && \
    mkdir -p /usr/local/src/rust                                                                    && \
    mv rustc-$RUST_VERSION/src /usr/local/src/rust/                                                 && \
    chmod -R a+rx /usr/local/src/rust                                                               && \
# source dir
    mkdir /source                                                                                   && \
# cleanup
    apt-get remove --purge -y curl                                                                  && \
    apt-get autoclean && apt-get clean                                                              && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/source"]
WORKDIR /source

CMD ["/bin/bash"]
