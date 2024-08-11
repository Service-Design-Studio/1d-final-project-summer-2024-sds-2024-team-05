[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/QpCtzJAE)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=15055754&assignment_repo_type=AssignmentRepo)

[Design Workbook](https://docs.google.com/document/d/1SXpq8aStl2y5TK2OTNNwD2Nqwt8G41vPAxLpP77D05s/edit?pli=1)

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Ruby version
- **Ruby** (`3.3.2`)

## System dependencies
### Ruby Gems
- **Rails** (`7.1.3.4`)
  - A web application framework for Ruby, providing default structures for a database, a web service, and web pages.

- **Puma** (`~> 5.0`)
  - A high-performance web server for Ruby/Rails applications.

- **Devise** (`~> 4.9.3`)
  - Flexible authentication solution for Rails with support for various features like password recovery and account locking.

- **RSpec-Rails** 
  - RSpec's Rails-specific testing tools, used for writing and running tests for Rails applications.

- **google-cloud-storage** 
  - Client library for Google Cloud Storage, used for interacting with Google Cloud buckets.

### JavaScript Libraries

- **Stimulus-Rails** 
  - A modest JavaScript framework for enhancing the behavior of HTML.

- **Turbo-Rails** 
  - Framework for building modern, fast, and reliable web applications by leveraging techniques like partial page updates.

### Database

This application uses different databases for various purposes:

- **PostgreSQL (Production)** 
  - A powerful, open-source relational database management system used for storing and managing application data in production. It provides robust support for complex queries and data integrity.

- **SQLite3 (Deployment)**
  - A lightweight, file-based relational database used for development and testing. It is included with Ruby on Rails by default for local development and testing environments due to its simplicity and ease of setup.
  - 

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

This project was deployed using Google Cloud Run, with a Cloud SQL instance for PostgreSQL managing general data and metadata. Google Cloud Storage is used for storing files (such as images and PDFs) and videos.

