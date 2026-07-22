#!/usr/bin/env sh

curl -X POST localhost:8080/applicants \
    -H "Content-Type: application/json" \
    -d '{"name": "Carol Davis",
    "experience": 0,
    "university": "HSE",
    "level": "Intern",
    "graduated": false,
    "education": "Bachelor",
    "specialty": "Fullstack",
    "dateOfBirth": "2006-04-17T00:00:00Z",
    "workHistory": "No prior experience",
    "languages": [
      "PL/SQL",
      "Eiffel",
      "PostScript",
      "Erlang",
      "Scratch"
    ],
    "technologies": [
      "Bootstrap",
      "Node.js",
      "Docker",
      "Ansible",
      "ZeroMQ"
    ]
  }'