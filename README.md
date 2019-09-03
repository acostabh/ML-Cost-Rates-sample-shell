User Cost Rates - Sample Shell Script - Mac/Linux Version #

This shell script (Mac/Linux) uses a Mavenlink API endpoint to view all the usr cost rates in an account, which is granted by your access token (see instructions below).

## Pre-Requisites ##

  1. Make the shell scripts executable
      - Navigate to the folder where you cloned the scripts (E.G: cd ~/Documents/ML-Invoices-shell)
      - Run this code (inside that folder only): chmod +x *.sh
  2. Linux: Install JQ via your distribution's application manager. eg: apt-get install jq
  3. Mac: Install the Homebrew Package Manager and the JQ JSON parser/compiler for Shell scripting
     - run the setup script: ./setup.sh (follow the prompts)
  4. Rename the file sample_token.json to token.json and update it with with your Mavenlink API token

## Running the script ##

  1. Open terminal
  2. Navigate to the folder where you saved the script
    - E.G: cd ~/Documents/ML-Cost-Rates-shell
  3. Run the script: ./get_cost_rate.sh