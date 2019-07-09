## Pdbg Docker

This is a simple docker image for building pdbg without having to install
the tools on your host machine. It does not test pdbg, only build.

It is published to Docker hub as shenki/pdbg-build.

It can be used as part of a travis job as follows:

```
     docker run \
        --env REPO=upstream \
        --rm \
        --workdir /travis \
        --volume ${TRAVIS_BUILD_DIR}:/travis \
        shenki/pdbg-build
```
