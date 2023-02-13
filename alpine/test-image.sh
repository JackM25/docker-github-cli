##
## Used to verify the built Docker image
##
## USAGE: test-image.sh <image>:<tag>
##
image_to_test=$1
all_tests_passed=true

test_program_exists () {
    #
    # Checks that a given command exists by running it and
    # checking for a 0 exit code.
    #
    local name=$1
    local command=$2

    echo "Checking $name exists in the container..."
    docker run --rm $image_to_test $command
    if [ $? -eq 0 ] 
    then
        echo -e "\033[0;32mPASS\033[0m\n"
    else
        echo -e "\033[0;31mFAILED\033[0m\n"
        all_tests_passed=false
    fi
}

if [ -z "${image_to_test}" ]; then
    echo -e "No image provided to test, exiting...\n"
    echo -e "\033[0;31mTESTS FAILED\033[0m"
    exit 1
fi

echo -e "Starting Tests on $image_to_test ...\n"


### TESTS ###
# Check required programs exist
test_program_exists "GitHub CLI" "gh version"
test_program_exists "cURL" "curl --version"
test_program_exists "Gzip" "which gzip"
test_program_exists "tar" "tar --version"
test_program_exists "wget" "which wget"
test_program_exists "jq" "which jq"

# Check the image is indeed built on Ubuntu
echo "Checking container is build on Alpine..."
CONTAINER_OS_NAME=`docker run --rm $image_to_test awk -F= '/^ID/{print $2}' /etc/os-release`
if [ "$CONTAINER_OS_NAME" = "alpine" ];
then
    echo -e "\033[0;32mPASS\033[0m\n"
else
    echo -e "\033[0;31mFAILED\033[0m\n"
    all_tests_passed=false
fi



if [ "$all_tests_passed" = true ] ; then
    echo -e '\033[0;32mALL TESTS PASSED\033[0m'
    exit 0
else
    echo -e '\033[0;31mTESTS FAILED. Please check the above log.\033[0m'
    exit 1
fi