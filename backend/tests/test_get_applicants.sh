#!/usr/bin/env zsh

curl -X GET http://158.160.175.91:8080/applicants \
    -H "Content-Type: application/json" \
    -d '{"experience":0, "level":"Middle", "languages_required":["Scratch"]}, "technologies_required":["Apache HTTP Server"]'