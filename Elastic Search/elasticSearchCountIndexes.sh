#!/bin/bash

#fetch documents count for multiple index
# specify the Elasticsearch endpoint and index name
#Elastic baseurl includes port number eg: http://localhost:8080
endpoint="base_url"
username="username"
password="password"

# Declare an array of string with type (for index name)
declare -a StringArray=("index1" "index2" "indexN" )

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
#for loop to loop through every index_name in array and fetch count 
#install jq and place in /usr/local/bin, add the path to environment variables
for index in ${StringArray[@]}; do
 echo $index
 curl -u $username:$password -X POST -H "Content-Type: application/json" -d "$query" "$endpoint/$index/_count" > response.json
 echo ""
 cat response.json | jq
 echo ""
done

#Note : data is fetched based on timestamp
