# Unofficial GitHub CLI Image

Unofficial GitHub CLI Docker Image, based on Apline.

This image is primarily designed for use in CI/CD pipelines, so is lightweight but includes useful tools such as:
*  `curl`
*  `gzip`
*  `tar`
*  `wget`

# Local Development
**To build the image locally**

```bash
docker build --build-arg GH_CLI_VERSION=<version> . -t <image>:<tag>
```
For example: `docker build --build-arg GH_CLI_VERSION=2.14.3 . -t github-cli:2.14.3`

**To Verify the Image**
```bash
./test-image.sh <image>:<tag>
```