Hatchd for Docker
================

[![Docker Stats](http://dockeri.co/image/hatchpay/hatchd)](https://hub.docker.com/r/hatchpay/hatchd/)

[![Build Status](https://travis-ci.org/hatchpay/docker-hatchd.svg?branch=master)](https://travis-ci.org/hatchpay/docker-hatchd/)


Docker image that runs the Hatch hatchd node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. Vultr, Digital Ocean, KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 4 GB to store the block chain files
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on Vultr 1024 MB RAM/320 GB disk instance @ $8/mo.  Vultr also *accepts Bitcoin payments*!  May run on the 512 MB instance, but took *forever* (1+ week) to initialize due to swap and disk thrashing.


Really Fast Quick Start
-----------------------

One liner for Ubuntu 14.04 LTS machines with JSON-RPC enabled on localhost and adds upstart init script:

    curl https://raw.githubusercontent.com/hatchpay/docker-hatchd/master/bootstrap-host.sh | sh -s trusty


Quick Start
-----------

1. Create a `hatchd-data` volume to persist the hatchd blockchain data, should exit immediately.  The `hatchd-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=hatchd-data
        docker run -v hatchd-data:/hatch --name=hatchd-node -d \
            -p 8888:8888 \
            -p 127.0.0.1:8884:8884 \
            hatchpay/hatchd

2. Verify that the container is running and hatchd node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        hatchpay/hatchd:latest          "hatch_oneshot"      2 seconds ago       Up 1 seconds        127.0.0.1:8884->8884/tcp, 0.0.0.0:8888->8888/tcp   hatchd-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f hatchd-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* To run in testnet, add environment variable `TESTNET=1` to `docker run` as such:

        docker run -v hatchd-data:/hatch --name=hatchd-node -d \
            --env TESTNET=1 \
            -p 8888:8888 \
            -p 127.0.0.1:8884:8884 \
            hatchpay/hatchd

* Additional documentation in the [docs folder](docs).

Credits
-------

Original work by Kyle Manna [https://github.com/kylemanna/docker-bitcoind](https://github.com/kylemanna/docker-bitcoind).
Modified to use Hatch Core instead of Bitcoin Core.

