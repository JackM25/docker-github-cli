##
## Used to verify the built Docker image
##
## USAGE: test-image.sh <image>:<tag>
##
image_to_test=$1

if [ -z "${image_to_test}" ]; then
    echo "No image provided to test, exiting..."
    exit 1
fi

echo "Starting Tests on $image_to_test"

docker run --rm  $image_to_test