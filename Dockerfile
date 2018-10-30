FROM phusion/baseimage
MAINTAINER Holger Schinzel <holger@www.org>

ARG USER_ID
ARG GROUP_ID

ENV HOME /hatch

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} hatch
RUN useradd -u ${USER_ID} -g hatch -s /bin/bash -m -d /hatch hatch

RUN chown hatch:hatch -R /hatch

ADD https://github.com/hatchpay/hatch/releases/download/v0.12.3.2/hatchcore-0.12.3.2-x86_64-linux-gnu.tar.gz /tmp/
RUN tar -xvf /tmp/hatchcore-*.tar.gz -C /tmp/
RUN cp /tmp/hatchcore*/bin/*  /usr/local/bin
RUN rm -rf /tmp/hatchcore*

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.
USER hatch

VOLUME ["/hatch"]

EXPOSE 8884 8888 18884 18888

WORKDIR /hatch

CMD ["hatch_oneshot"]
