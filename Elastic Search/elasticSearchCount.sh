#!/bin/bash

# specify the Elasticsearch endpoint and index name
endpoint="base_url"
index_name="index_name"
username="username"
password="password"

# specify the Elasticsearch query to retrieve all documents
#Set the time as per you
query='{
   "query": {
      "bool": {
         "filter": {
            "range": {
               "timestamp": {
                 "time_zone": "+05:30",        
                 "lte": "now-30d" 
               }
            }
         }
      }
   }
}'

#lte means less than or equal to, so the above query will return data >= currentTime to last 30 days

# perform the HTTP request to Elasticsearch and save the response JSON data to a file
#_count to count the documents that are fetched
curl -u $username:$password -X POST -H "Content-Type: application/json" -d "$query" "$endpoint/$index_name/_count" > response.json

#install jq and place in /usr/local/bin, add the path to environment variables
echo ""
cat response.json | jq

#Note : data is fetched based on timestamp
