[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/QpCtzJAE)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=15055754&assignment_repo_type=AssignmentRepo)

[Design Workbook](https://docs.google.com/document/d/1SXpq8aStl2y5TK2OTNNwD2Nqwt8G41vPAxLpP77D05s/edit?pli=1)

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

This project was deployed using Google Cloud Run, with a Cloud SQL instance for PostgreSQL managing general data and metadata. Google Cloud Storage is used for storing files (such as images and PDFs) and videos.

## Cloud Run Deployment

Google Cloud Run is used to deploy the application. It provides a fully managed environment for running containerized applications, scaling automatically with traffic.

### Prerequisites

1. **Google Cloud Account**: Ensure you have a Google Cloud account with billing enabled.
<!--2. **Google Cloud SDK**: Install the Google Cloud SDK and authenticate with your account.-->

### Setup Steps
1. **Create a project on Google Cloud**

2. **Enable Cloud Run API**
   
3. **Setup PostgreSQL Instance**

4. **Create a Google Cloud Storage Bucket**

Before deploying or even testing the app locally, you will need to set up a Google Cloud Storage bucket. This bucket will be used to store files and videos.

You might ask: why do I even need the Google Cloud Storage Bucket when I am testing locally, especially when using sqlite3 for local development and testing (easier to manage, set up and use but not as scalable and ideal for production).
Two reasons:
1. Initially, Active Storage was used for managing files and videos. This made it uniform for both local development and testing and even for production as Active Storage can automatically help to connect to Google Cloud Bucket once configured properly. However, it encountered limitations with larger files, such as videos exceeding approximately 30MB. This resulted in a "Request Entity Too Large" error due to the 32MB limit imposed by Cloud Run, presumably because of the 32mb cloud run limit. So any video/entity that passes through the cloud run server will seem to contribute to this limit. We searched for ways to overcome this issue and decided on direct upload to the google cloud bucket using signed urls via client side and subsequently saving the filename together as a form of metadata relating it to the patient/form. Overall, we thought this would be necessary as a 1 min long video taken by phone would probably already be > 30mb.
2. Our app connects to a flask microservice for the CV processing to work. It did not make sense to us to send the file over http request because of the reason in point 1, increased complexity, scalability issues, increased latency and more as compared to retrieving and uploading from Google Cloud Bucket directly which is optimised to handle large file uploads and retrievals.
Cons of using Google Cloud Storage Bucket when developing locally - Cost incurred rather than totally free, although probably not as expensive as running a PGSQL instance for production.
Hence, we decided to code it this way from the get-go.

5. **Ensure CORS setup**
It should be something like this. This allows you to PUT a video directly to Google Cloud Bucket via a generated signed URL. I believe the domains refer to where the request can be sent from.
[{"maxAgeSeconds": 3600, "method": ["GET", "HEAD", "PUT", "POST"], "origin": ["http://localhost:3000", "https://ninkatec-2-7tifx5rv7q-as.a.run.app", "http://127.0.0.1:3000"], "responseHeader": ["*"]}]

6. **Create a service account for bucket management and ensure it has the role permissions**
We gave it a Storage Admin such that it has full access to the bucket generate a JSON key from the bucket as you will need it in your app to give it credentials (under app/services/google_cloud_storage_service) to generate URLs and so on. For the flask microservice, it can either use the same JSON key or if using a separate project, create a new service account with its respective key but I believe you will need to give that service account permission in the original project.

