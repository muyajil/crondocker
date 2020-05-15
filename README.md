# crondocker

Docker container specifically to run cronjobs

## Description
- The container on its own handles the cronjob part, but you need to be sure to provide the dependencies for this.
- Essentially the script `crondocker.sh` does the following:
  - Look for a crontab at `/crontab` and exit if it does not exists
  - Otherwise add the log pipe at the end of each command to log everything to `/crondocker.log`
  - Then tail and follow the logs

## Usage
- The initial purpose of this image is to be able to register and run cronjobs in a project using docker-compose
- This allows to setup up the project using `docker-compose up` including cronjobs
- To use this image do the following:
  - Assume that you have a project with a `docker-compose.yml` ready and you would like to run cronjobs related to that project
  - Create a new directory `crondocker`
  - Create a new `Dockerfile` in there
  - Derive from this image
  - Install your dependencies
  - Add a file `crontab` which contains your cronjobs
  - Add any files you want to use within the container
  - Add the following to your `docker-compose.yml`:
```
services:
  crondocker:
    build: ./crondocker
    image_name: crondocker-custom
    volumes:
      - "./crondocker/crontab:/crontab"
      - "/other/needed/volume/:/other/needed/path/"
```
  - Here you can see an example on how to set it up: https://github.com/muyajil/muyflix/tree/master/crondocker