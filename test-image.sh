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
        echo -e "PASS\n"
    else
        echo -e "FAILED\n"
        all_tests_passed=false
    fi
}

if [ -z "${image_to_test}" ]; then
    echo "No image provided to test, exiting..."
    exit 1
fi

echo -e "Starting Tests on $image_to_test ...\n"

# TESTS
test_program_exists "GitHub CLI" "gh version"
test_program_exists "cURL" "curl --version"
test_program_exists "Gzip" "which gzip"
test_program_exists "tar" "tar --version"
test_program_exists "wget" "which wget"


if [ "$all_tests_passed" = true ] ; then
    echo 'ALL TESTS PASSED'
    exit 0
else
    echo 'TESTS FAILED. Please check the above log.'
    exit 1
fi