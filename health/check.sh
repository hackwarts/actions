#!/bin/bash

request_id=$(uuidgen)
api_key=${API_KEY:-}
endpoint=${ENDPOINT:-}

if [ -z "$endpoint" ]; then
    echo -e "\n\033[1;31m❌ ENDPOINT is not present in ENV\n"
    exit 1
fi

if [ -z "$api_key" ]; then
    echo -e "\n\033[1;31m❌ API_KEY is not present in ENV\n"
    exit 1
fi

echo -e "START: check {
    endpoint: $endpoint
    request_id: $request_id,
}"

response=$(curl -s -H "api_key: $api_key" "$endpoint?request_id=$request_id")
response_id=$(echo "$response" | tr -d '"')

if [ "$request_id" != "$response_id" ]; then
    echo -e "ERROR: check {
    endpoint: $endpoint
    request_id: $request_id,
    response_id: $response_id
}"
    echo -e "\n\033[1;31m❌ request and response IDs do not match\n"
    exit 1
fi

echo -e "END: check {
    endpoint: $endpoint
    request_id: $request_id,
    response_id: $response_id
}"

echo -e "\n\033[1;32m✅ service is healthy\n"
