FROM debian:jessie
MAINTAINER Michele Bertasi

ENV RUST_VERSION=1.9.0                                                                                 \
    RUST_TARGET=x86_64-unknown-linux-gnu

# install pagkages
RUN apt-get update                                                                                  && \
    apt-get install -y --no-install-recommends build-essential curl ca-certificates git gdb         && \
# install rust binaries
    cd /tmp                                                                                         && \
    curl -sO https://static.rust-lang.org/dist/rust-$RUST_VERSION-$RUST_TARGET.tar.gz               && \
    tar -xvzf rust-$RUST_VERSION-$RUST_TARGET.tar.gz                                                && \
    ./rust-$RUST_VERSION-$RUST_TARGET/install.sh --without=rust-docs                                && \
# install rust sources
    curl -sO https://static.rust-lang.org/dist/rustc-$RUST_VERSION-src.tar.gz                       && \
    tar -xvzf rustc-$RUST_VERSION-src.tar.gz                                                        && \
    cd rustc-$RUST_VERSION                                                                          && \
    rm -rf src/llvm src/test src/compiler-rt                                                        && \
    mkdir -p /usr/local/src/rust                                                                    && \
    mv src /usr/local/src/rust/                                                                     && \
# fix permissions
    find /usr/local/src/rust -type d -exec chmod a+x {} \;                                          && \
    chmod -R a+r /usr/local/src/rust                                                                && \
# cleanup
    apt-get remove --purge -y curl                                                                  && \
    apt-get autoremove -y && apt-get autoclean && apt-get clean                                     && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
