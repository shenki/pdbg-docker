## Pdbg Docker

This is a simple docker image for building pdbg without having to install
the tools on your host machine. It does not test pdbg, only build.

It is published to Docker hub as shenki/pdbg-build.

To do a build of upstream's master branch:

It can be used as part of a travis job as follows:

```
     docker run --rm shenki/pdbg-build
```

To build for powerpc64le:
```
     docker run --rm shenki/pdbg-build --host=powerpc64le-linux-gnu
```

To run under Travis:
```
     docker run \
        --env REPO=upstream \
        --rm \
        --workdir /travis \
        --volume ${TRAVIS_BUILD_DIR}:/travis \
        shenki/pdbg-build
```

To make the source and build available in `~/pdbg-build` after the build:

```
     docker run \
        --rm \
	-v ~/pdbg-build/:/build -w /build \
	shenki/pdbg-build
```
