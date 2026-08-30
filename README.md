# HeadlessHunter

A full-stack recruitment platform for discovering applicants, companies, and job opportunities from one interface.

I built this project end to end, from data modeling and REST API design to authentication, search workflows, and a cross-platform user interface.

## What it does

- Provides searchable directories of applicants, companies, and vacancies
- Supports detailed profiles for each record
- Filters results by technologies, languages, experience, and other criteria
- Includes account registration and login with JWT-based authentication
- Lets authenticated users publish and manage listings
- Offers a responsive Flutter interface with light and dark themes

## Architecture

- **Frontend:** Flutter and Dart, with Riverpod for state management and Dio for API communication
- **Backend:** Go REST API built with Gin
- **Data layer:** SQLite with sqlx, plus structured seed data
- **Authentication:** Password hashing and JSON Web Tokens
- **Deployment:** Container-ready backend with Docker

## Repository structure

```text
backend/    Go API, authentication, data models, repositories, and request tests
frontend/   Flutter application, state management, services, and UI
```

## Technical focus

This project gave me experience designing a multi-entity data model, connecting a typed client to a REST API, implementing authentication and protected routes, and building search and publishing flows across the full stack.

## Status

This is an actively developed portfolio project. The repository contains the complete frontend and backend source; deployment secrets and environment-specific configuration are not included.
