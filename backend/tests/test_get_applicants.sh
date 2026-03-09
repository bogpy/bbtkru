#!/usr/bin/bash

curl -X GET http://localhost:8080/applicants \
    -H "Content-Type: application/json" \
    -d '{"experience":0, "level":"Middle", "languages_required":["Scratch"]}, "technologies_required":["Apache HTTP Server"]'