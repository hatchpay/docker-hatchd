# Debugging

## Things to Check

* RAM utilization -- hatchd is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The hatch blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 2GB+ is necessary.

## Viewing hatchd Logs

    docker logs hatchd-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the hatchd node, but will not connect to already running containers or processes.

    docker run -v hatchd-data:/hatch --rm -it hatchpay/hatchd bash -l

You can also attach bash into running container to debug running hatchd

    docker exec -it hatchd-node bash -l


