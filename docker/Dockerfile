FROM debian:bookworm-slim

RUN --mount=type=tmpfs,target=/var/lib/apt/lists apt-get update \
    && apt-get install -y --no-install-recommends build-essential ca-certificates curl git python3 \
    && groupadd --gid 10001 golf \
    && useradd --uid 10001 --gid 10001 --create-home golf \
    && install -d -o golf -g golf /opt/elan /opt/lean-golf /work

ENV ELAN_HOME=/opt/elan
ENV PATH=/opt/elan/bin:$PATH
USER golf
WORKDIR /opt/lean-golf

COPY --chown=golf:golf lean-toolchain lakefile.toml lake-manifest.json ./
RUN --mount=type=tmpfs,target=/tmp curl --fail --silent --show-error --location \
      https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh \
      --output /tmp/elan-init.sh \
    && sh /tmp/elan-init.sh -y --no-modify-path --default-toolchain none \
    && elan toolchain install "$(cat lean-toolchain)"

RUN --mount=type=cache,target=/home/golf/.cache/mathlib,uid=10001,gid=10001 \
    lake exe cache get

COPY --chown=golf:golf . ./
RUN lake build && lake build golfcheck
