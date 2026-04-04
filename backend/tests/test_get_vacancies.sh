#!/usr/bin/env sh

curl "http://158.160.175.91:8080/vacancies?experience=3&salary=42000&employment=Full-time&location=Hybrid&hours=40&country=USA"

#curl -X GET http://158.160.175.91:8080/vacancies \
    #-H "Content-Type: application/json" \
    #-d '{"experience":3, "salary":42000, "employment":"Full-time", "location":"Hybrid", "hours":40}'

#curl -X GET http://158.160.175.91:8080/vacancies \
    #-H "Content-Type: application/json" \
   # -d '{"salary":26}'
