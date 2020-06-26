### Versioning: set all the following per your environment
ARG DEBIAN_BASE="debian"
ARG DEBIAN_TAG="stable-slim"
FROM ${DEBIAN_BASE}:${DEBIAN_TAG}
ARG KERNEL_VERSION="4.19.0-9"
ARG ONLOAD_VERSION="7.0.0.265"
ARG ONLOAD_MD5SUM="100c32eee5b3dd1213b3db79f6c3670"
ARG ONLOAD_URL="https://support.solarflare.com/index.php/component/cognidox/?task=download&file=SF-122921-DH-2.xml&subdoc=SF-109585-LS&subissue=33&o=1&format=raw"
### end versioning

COPY source /app
RUN \
    DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        ca-certificates \
        coreutils \
        curl \
        ethtool \
        gcc \
        gcc-multilib \
        kmod \
        libc6-dev-i386 \
        libpcap0.8-dev \
        libtool-bin \
	linux-headers-${KERNEL_VERSION}-all-amd64 \
        make \
        net-tools \
        perl \
        python-dev \
        sed \
        tar \
        unzip \
        valgrind \
        vim \
        wget \
    && cd /tmp \
    && curl -fSL "${ONLOAD_URL}" -o /tmp/onload-${ONLOAD_VERSION}-package.zip \
    && echo "${ONLOAD_MD5SUM} /tmp/onload-${ONLOAD_VERSION}-package.zip" | md5sum --check \
    && unzip /tmp/onload-${ONLOAD_VERSION}-package.zip \
    && tar -zxf onload-${ONLOAD_VERSION}.tgz ; \
    mv onload-${ONLOAD_VERSION} onload_src ; 

ENTRYPOINT ["/app/build"]
LABEL KERNEL_VERSION="${KERNEL_VERSION}"
LABEL ONLOAD_VERSION="${ONLOAD_VERSION}"
