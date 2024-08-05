# Stress Test Practice

This project is designed to create a simple web page that accepts requests and stores data from requests to a database. It also includes scripts to perform stress tests using Siege.

## Prerequisites

- Node.js (https://nodejs.org/)
- pnpm (https://pnpm.io/)
- Siege (will be installed by the script if not already installed)

## Setup

1. Clone the repository and navigate to the project directory:

    ```bash
    git clone git@github.com:statechny/stress-test.git
    cd stress-test
    ```

2. Install dependencies:

    ```bash
    pnpm install
    ```

## Running the Server

1. Start the server:

    ```bash
    node server.js
    ```

   You should see the output:

    ```plaintext
    Server is running on port 5000
    ```

## Running the Tests

1. Open a new terminal window and navigate to your project directory:

    ```bash
    cd path/to/your/stress-test
    ```

2. Make the script executable (if you haven't already):

    ```bash
    chmod +x run_siege_tests.sh
    ```

3. Run the Siege tests:

    ```bash
    ./run_siege_tests.sh
    ```

   This script will:
    - Check if Siege is installed and install it if necessary.
    - Run Siege with different concurrency levels (10, 25, 50, 100).

## Test Results Comparison

| Concurrency Level | Availability | Avg Response Time | Throughput  |
|-------------------|--------------|-------------------|-------------|
| 10                | 100%         | 0.0 secs          | 0.17 MB/sec |
| 25                | 99.90%       | 0.2 secs          | 0.01 MB/sec |
| 50                | 99.84%       | 0.5 secs          | 0.01 MB/sec |
| 100               | 99.92%       | 0.19 secs         | 0.01 MB/sec |

### Explanation of Results

- **Availability:** The percentage of successful transactions out of the total number of transactions.
- **Avg Response Time:** The average time it took to complete a transaction.
- **Throughput:** The amount of data transferred per second.

## Notes

- Ensure that the server is running before starting the tests.
- The results may vary based on your machine's performance and network conditions.
