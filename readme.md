# Kinect2 Docker 

This repo can run libfreenect2 for the xbox one camera.

## Usage
```bash
$ xhost +si:localuser:root
$ docker-compose up --build
```
Hopefully as simple as that.

## Dependencies
* Nvidia Docker v2
* Xbox one camera
* Linux

## Common issues

Sometimes you need to change the current active `DISPLAY`. To do this edit the the docker-compose.yml to:

```
environment:
  - "DISPLAY=:1"
```
