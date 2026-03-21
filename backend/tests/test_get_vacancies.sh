#!/usr/bin/env sh

curl -X GET http://158.160.175.91:8080/vacancies \
    -H "Content-Type: application/json" \
    -d '{"experience":3, "salary":265000, "employment":"Full-time", "location":"Hybrid", "hours":13, "country":"USA"}'

curl -X GET http://158.160.175.91:8080/vacancies \
    -H "Content-Type: application/json" \
    -d '{"salary":26}'
