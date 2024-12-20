# Journal Management System

A GraphQL-based journal management system built with Ruby on Rails, enabling users manage journals, posts, comments, and users. This project features user authentication with JWT tokens and supports efficient data handling through input types and mutations.

## Getting Started

* bundle install
* set local env variables:
```bash
  JWT_SECRET={JWT_SECRET}
```
* set database variables (config/database.yml)

* use the url: {website_url}/graphql to access the graphql playground and schema

* for authentication, use the auth token in the header (optained from the create user or sign in mutation):
```graphql
  {
  "Authorization": "Bearer <token>"
  }
```