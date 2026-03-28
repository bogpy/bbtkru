#!/usr/bin/env sh

curl "http://158.160.175.91:8080/applicants?experience=2&level=Senior&specialty=Backend"
#curl "http://158.160.175.91:8080/companies?country=USA&employeeCount=100"

# curl -X GET http://158.160.175.91:8080/vacancies \
#     -H "Content-Type: application/json" \
#     -d '{"experience":2, "salary":100000, "employment":"Full-time", "location":"Remote", "country":"USA"}'