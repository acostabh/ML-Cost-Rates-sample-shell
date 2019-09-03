#!/bin/sh
#Getting user cost rates via the account membership endpoint API

echo off
token=$(jq -r ".token" token.json)

acc_membership=$(curl -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/account_memberships?include=cost_rates,user&only_active=true')
user_count=$(jq -n "$acc_membership" | jq -r '.count')
$user_count
if [ $user_count == 0 ]; then
  echo "No User found!"
else
  echo ""
  echo "#################### Users & Cost rates ##################"
  echo ""

  #iterate for each account membership ID
  for (( i=0; i < $user_count; ++i ))
    do
      membership_id=$(jq -n "$acc_membership" | jq -r '.results['$i'].id')
      cost_rate_count=$(jq -n "$acc_membership" | jq -r '.account_memberships["'$membership_id'"].cost_rate_ids' | jq length)
      user_id=$(jq -n "$acc_membership" | jq -r '.account_memberships["'$membership_id'"].user_id')
      user_name=$(jq -n "$acc_membership" | jq -r '.users["'$user_id'"].full_name')

      echo "User ["$user_id"]: "$user_name
        echo "--------------------------------------"
        #iterate for each cost rate ID and printout the user and cost rate details
        if [ $cost_rate_count == 0 ]; then
          echo "No cost rate set - use account default."
        fi
        for (( j=0; j < $cost_rate_count; ++j ))
          do
            id=$(jq -n "$acc_membership" | jq -r '.account_memberships["'$membership_id'"].cost_rate_ids['$j']')
            #echo $id
            cost_rate_currency=$(jq -n "$acc_membership" | jq -r '.cost_rates["'$id'"].currency')
            cost_rate_amount=$(jq -n "$acc_membership" | jq -r '.cost_rates["'$id'"].amount_in_subunits'/100)
            cost_rate_active=$(jq -n "$acc_membership" | jq -r '.cost_rates["'$id'"].in_use')
            #only show active cost_rates
            #if [ $cost_rate_active == true ]; then
              echo "Rate ["$id"]: " $cost_rate_currency $cost_rate_amount
            #fi
          done
      #echo "--------------------------------------"
      echo ""

   done
fi
