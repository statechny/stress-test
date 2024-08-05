#!/bin/bash

# Function to install Siege on Debian-based Linux (e.g., Ubuntu)
install_siege_linux() {
    sudo apt-get update
    sudo apt-get install -y siege
}

# Function to install Siege on macOS using Homebrew
install_siege_macos() {
    if ! command -v brew &> /dev/null
    then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    brew install siege
}

# Check the operating system and install Siege accordingly
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "Detected Linux OS"
    if ! command -v siege &> /dev/null
    then
        echo "Siege is not installed. Installing Siege..."
        install_siege_linux
    else
        echo "Siege is already installed"
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS"
    if ! command -v siege &> /dev/null
    then
        echo "Siege is not installed. Installing Siege..."
        install_siege_macos
    else
        echo "Siege is already installed"
    fi
else
    echo "Unsupported OS type: $OSTYPE"
    exit 1
fi

# Define the URL file and concurrency levels
URLS_FILE="urls.txt"
CONCURRENCY_LEVELS=(10 25 50 100)
REQUESTS=1000 # Total number of requests to send

# Loop through each concurrency level and run siege
for CONCURRENCY in "${CONCURRENCY_LEVELS[@]}"; do
    echo "Running siege with concurrency level: $CONCURRENCY in bench mode"
    siege -b -c$CONCURRENCY -r$REQUESTS -f $URLS_FILE > "siege_results_${CONCURRENCY}.txt"
done
