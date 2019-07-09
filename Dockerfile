FROM ubuntu:rolling
ENV DEBIAN_FRONTEND noninteractive
RUN apt update -qq && apt install -yy --no-install-recommends \
            make gcc autoconf automake libtool git ca-certificates device-tree-compiler \
	    && rm -rf /var/cache/archive
RUN if [ `arch` = "x86_64" ]; then apt update -qq && apt install -yy --no-install-recommends \
            gcc-arm-linux-gnueabi libc-dev-armel-cross gcc-powerpc64le-linux-gnu libc-dev-ppc64el-cross \
	    && rm -rf /var/cache/archive; fi
RUN if [ `arch` = "ppc64le" ]; then apt update -qq && apt install -yy --no-install-recommends \
            gcc-arm-linux-gnueabi libc-dev-armel-cross gcc-x86-64-linux-gnu libc-dev-amd64-cross \
	    && rm -rf /var/cache/archive; fi
COPY driver.sh /usr/local/bin
ENTRYPOINT ["driver.sh"]
