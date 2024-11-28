# Blog Management System

A GraphQL-based blog management system built with Ruby on Rails, enabling users to create, read, update, and delete journals (blogs), posts, comments, and users. This project features user authentication with JWT tokens and supports efficient data handling through input types and mutations.

## Features

- **User Authentication**: Sign up and sign in with JWT token management.
- **CRUD Operations**: Create, read, update, and delete journals, posts, and comments.
- **GraphQL API**: A fully functional GraphQL API for seamless data interaction.
- **Data Validation**: Ensure data integrity with model validations and error handling.

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
