#!/bin/bash
# This is a script to fetch covid19 data for all countries from covid19api.com
# Note that a country list is saved in covid19.countries
# Written by Abdullah Alrajeh, Aug 2020
# Use: ./covid19.sh "Saudi Arabia"

# fetch covid19 data if the last version older than one hour
t=`cat covid19.timestamp`
if [ `date +%s` -ge $((t+3600)) ]; then
  curl --location --request GET 'https://api.covid19api.com/summary' > covid19.summary
  cat covid19.summary | grep -o Country\"[^,]* | cut -d'"' -f3 > covid19.countries
  date +%s > covid19.timestamp
fi

cat covid19.summary | grep -o Country\"[^}]* | grep "$1" | cut -d',' -f4-9
