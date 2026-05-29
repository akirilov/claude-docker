# Claude Docker

This is a proof-of-concept for running Claude inside Docker for automated fire-and-forget tasks, such as initial recon on a pentest

## Disclaimer

**USE AT YOUR OWN RISK**

This is essentially a harness to run claude inside Docker unattended. Network isolation is left as an exercise to the reader. Docker
provides some sandboxing but you should probably still run it in an isolated VM, but hey it's your machine, do what you want.

## Usage

See `run.sh` and `in/example`. Don't forget to actually buid the dockerfile
