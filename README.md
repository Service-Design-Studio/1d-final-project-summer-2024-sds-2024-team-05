[![Review Assignment Due Date](https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-05/blob/main/ruby-app/public/review-assignment-button.svg)](https://classroom.github.com/a/QpCtzJAE)
[![Open in Visual Studio Code](https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-05/blob/main/ruby-app/public/open-in-vscode.svg)](https://classroom.github.com/online_ide?assignment_repo_id=15055754&assignment_repo_type=AssignmentRepo)

[Design Workbook](https://docs.google.com/document/d/1SXpq8aStl2y5TK2OTNNwD2Nqwt8G41vPAxLpP77D05s/edit?pli=1)

# Ninkatec Patient Onboarding WebApp

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Overview](#overview)
- [Installation](#installation)
- [Google Cloud Deployment](#cloud-run-deployment)
- [Developer Team](#developer-team)
<!-- - [Usage](#usage)
- [Configuration](#configuration)
- [Contributing](#contributing)
- [License](#license) -->


## Introduction
**Ninkatec Patient Onboarding WebApp** is a web application that streamlines and digitalises the tedious client onboarding process and create a more efficient solution which captures holistic and accurate client profiles, so as to reduce the workload of the staff and next-of-kin.

[Check out our Google Site Here for a more detailed context regarding the problem and solution](https://sites.google.com/view/team-delta-sds/home)

## Features
### User (Patient's Next of Kin)
- User Sign-Up and User Login
- Creation, Submission, Editing, Deleting of Patient Application Forms (CRUD operations)
- Dashboard of all ongoing/submitted patient applications

### Staff
- Admin Login for Staff
- Creation, Submission, Editing, Deleting of Patient Application Forms (CRUD operations)
- Preliminary AI Assessment of Patient's uploaded physical and mental assessment videos
  - Transcription of Patient and NOK Conversation
  - Count of unique animals listed by patient
  - Sit-stand Test Computer Vision assessment
- Detailed Client Profile when clicking in from dashboard
- Manual input for assessing Patients uploaded videos
- Admin Dashboard Management System
  - Sorting based on different columns
  - Search functionality for patient or next-of-kin name
  -  Colour coded statuses for next action required
- Self-built calendar
  - Schedule Meetings (house visit appointments) with Patient and Users (Patient's Next of Kin) or for Internal Use (No association with Patients or Users)
  - Toggle monthly or weekly view of calendar to see all scheduled meetings with details of attached patient (if applicable)
- Automated Email Notifications sent to User for Meeting Management (upon creating, rescheduling, and cancelling meetings)

## Overview
This project has 3 different folders, each with a different purpose and their own README for how to install and use them. This is because they need to be set up differently, especially for ruby-app and flask-app.

Click on folder or Link to [cv-models](https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-05/tree/main/cv-models)

Click on folder or Link to [flask-app](https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-05/tree/main/flask-app)

Click on folder or Link to [ruby-app](https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-05/tree/main/ruby-app)
```
Repo/
│
├── README.md          # Main README with overall project details and deployment steps for the entire project
├── cv-models/
│   ├── README.md      # README for cv-models
│   ├── cv ipynb       # python ipynbs for testing cv model
│
├── flask-app/         
│   ├── README.md      # README for flask-app installation and setup
│   ├── app1.py
│   ├── other files
│   └── requirements.txt
│
└── ruby-app/
    ├── README.md      # README for ruby-app installation and setup
    ├── app
    └── other folders
```

## Installation
### Prerequisites
- Ruby on Rails
- Python
- Google Cloud account
- Google Cloud Bucket

## System dependencies
Details of specific Ruby / python dependencies can be found within their own folders README.

### Database

This application uses different databases for various purposes:

- **PostgreSQL (Production)** 
  - A powerful, open-source relational database management system used for storing and managing application data in production. It provides robust support for complex queries and data integrity.

- **SQLite3 (Deployment)**
  - A lightweight, file-based relational database used for development and testing. It is included with Ruby on Rails by default for local development and testing environments due to its simplicity and ease of setup.

This project was deployed using Google Cloud Run, with a Cloud SQL instance for PostgreSQL managing general data and metadata. Google Cloud Storage is used to store files (such as images and PDFs) and videos.

## Cloud Run Deployment

Google Cloud Run is used to deploy the application. It provides a fully managed environment for running containerized applications, scaling automatically with traffic.

### Prerequisites

1. **Google Cloud Account**:

   Ensure you have a Google Cloud account with a billing account enabled.

### Setup Steps
1. **Create a project on Google Cloud**

   Create a project and project ID on Google Cloud Console or via terminal. Make sure that billing is enabled for your Cloud project.

2. **Enable Cloud Run API**
   
   Enable the Cloud Run, Cloud SQL, Cloud Build, Secret Manager, and Compute Engine APIs. [Enable Cloud Run APIs](https://console.cloud.google.com/flows/enableapi?apiid=run.googleapis.com,sql-component.googleapis.com,sqladmin.googleapis.com,compute.googleapis.com,cloudbuild.googleapis.com,secretmanager.googleapis.com) or search in Google Cloud Console for Enable Cloud Run APIs

3. **Enable Cloud Speech To Text API**
    - [Enable Cloud Speech To Text API](https://console.cloud.google.com/marketplace/product/google/speech.googleapis.com)
    - Go to API's and Services tab on Google Cloud Console
    - Select Credentials
    - + Create Credentials -> API Key
    - Copy API Key
    - Go to `Rails-App-Directory/app/services/transcription_service.rb` and replace `<key>` in `GOOGLE_SPEECH_API_URL = "https://speech.googleapis.com/v1/speech:recognize?key=<key>"`
   
4. **Setup PostgreSQL Instance**
   
    - In the Cloud Console, go to the Cloud SQL Instances page. [CloudSQL Instance page](https://console.cloud.google.com/sql/instances?)
    - Click Create Instance.
    - Click Choose PostgreSQL.
    - In the Instance ID field, enter a name for the instance (INSTANCE_NAME).
    - In the Password field, enter a password for the postgres user or click generate password. Save it somewhere for emergency purposes.
    - Choose Singapore for region and “Single Zone” for Zone availability.
    - Use the default values for the other fields.
    - Click Create Instance.

5. **Create a Database for your PostgreSQL Instance**
   
    - In the Cloud Console, go to the Cloud SQL Instances page. Go to the [CloudSQL Instance page](https://console.cloud.google.com/sql/instances?).
    - Select the INSTANCE_NAME instance. (Same instance you just created in previous step)
    - Go to the Databases tab.
    - Click Create database.
    - In the Database name dialog, enter DATABASE_NAME.
    - Click Create.
     
6. **Create a User for your Database**
   
    - In the Cloud Console, go to the Cloud SQL Instances page. Go to the Cloud SQL Instances page.
    - Select the INSTANCE_NAME instance.
    - Go to the Users tab.
    - Click Add User Account.
    - **Before the following steps: you need to generate a random password and write it into a file called dbpassword**
    - Command to do so is ```cat /dev/urandom | LC_ALL=C tr -dc '[:alpha:]'| fold -w 50 | head -n1 > dbpassword``` or equivalent command
    - Under the Built-in Authentication dialog:
    - Enter the user name DATABASE_USERNAME. (Can be different from the previous DATABASE_NAME as they are separate things)
    - Enter the content of the dbpassword file as the password PASSWORD.
    - Click Add.
   
7. **Create a Google Cloud Storage Bucket**

   Before deploying or even testing the app locally, you will need to set up a Google Cloud Storage bucket (Recommended by us to set up one for development and one for actual production, probably best to have different project - development without all the cloud run & SQL instances to avoid confusion). This bucket will be used to store files and videos.
   
   You might ask: why do I even need the Google Cloud Storage Bucket when I am testing locally, especially when using sqlite3 for local development and testing (easier to manage, set up and use but not as scalable and ideal for production).
   Two reasons:
   1. Initially, Active Storage was used for managing files and videos. This made it uniform for both local development and testing and even for production as Active Storage can automatically help to connect to Google Cloud Bucket once configured properly. However, it encountered limitations with larger files, such as videos exceeding approximately 30MB. This resulted in a "Request Entity Too Large" error due to the 32MB limit imposed by Cloud Run, presumably because of the 32mb cloud run limit. So any video/entity that passes through the cloud run server will seem to contribute to this limit. We searched for ways to overcome this issue and decided on direct upload to the google cloud bucket using signed urls via client side and subsequently saving the filename together as a form of metadata relating it to the patient/form. Overall, we thought this would be necessary as a 1 min long video taken by phone would probably already be > 30mb.
   2. Our app connects to a flask microservice for the CV processing to work. It did not make sense to us to send the file over http request because of the reason in point 1, increased complexity, scalability issues, increased latency and more as compared to retrieving and uploading from Google Cloud Bucket directly which is optimised to handle large file uploads and retrievals.
   Cons of using Google Cloud Storage Bucket when developing locally - Cost incurred rather than totally free, although probably not as expensive as running a PGSQL instance for production.
   Hence, we decided to code it this way from the get-go.

    - In the Cloud Console, go to the Cloud Storage Browser page. Go to [Browser](https://console.cloud.google.com/storage/browser).
    - Click Create bucket.
    - On the Create a bucket page, enter your bucket information. To go to the next step, click Continue.
    - For Name your bucket, enter a name that meets the bucket naming requirements.
    - Select “Region” for Location Type, and choose "asia-southeast1". 
    - For Choose a default storage class for your data, select the following: Standard.
    - For Choose how to control access to objects, select Uniform for an Access control option. Make sure you uncheck public access prevention.
    - Click Create.

    At the end of this step, you would have a Cloud SQL Instance Name, Database Name, Database_User Name, dbpassword and Bucket Name 

8. **Grant Cloud Build access to Cloud SQL**

    - In the Cloud Console, go to the Identity and Access Management page. Go to the Identity and Access Management page.
    - To edit the entry for ```PROJECTNUM@cloudbuild.gserviceaccount.com``` member, click create Edit Member.
    - Click Add **another** role (Do not overwrite existing role)
    - In the Select a role dialog, select Cloud SQL Client.
    - Click Save
    
    - In the Cloud Console, go to the Cloud Build Settings page.
    - Open the Settings page
    - Locate the row with the Cloud Run Admin role and set its Status to ENABLED.
    - In the Additional steps may be required pop-up, click GRANT ACCESS TO ALL SERVICE ACCOUNTS.

9. **Generate Secret Key Base**

    Command: ```bundle exec rake secret``` or ```rails secret``` and store it in a .env or somewhere first.
   
10. **Ensure CORS setup**

   When you use a PUT request to upload a video to a signed URL, the browser recognizes this as a cross-origin request. By default, the browser will block this request unless the server explicitly allows it through CORS headers.
   
   Command to find out what your CORS set up is ```gsutil cors get gs://<YOUR-BUCKET-NAME```

   Expected Response of the CORS set up should be like:
   ```[{"maxAgeSeconds": 3600, "method": ["GET", "HEAD", "PUT", "POST"], "origin": ["http://localhost:3000", "https://ninkatec-2-7tifx5rv7q-as.a.run.app", "http://127.0.0.1:3000"], "responseHeader": ["*"]}]```

  

   To set your CORS setup, create a JSON file named cors-config.json (or any name you prefer) with the CORS settings.
   Command to set your CORS set up is ```gsutil cors set cors-config.json gs://YOUR_BUCKET_NAME```

11. **Create a service account for bucket management and ensure it has the role permissions**

    - Create a service account for bucket management under IAM & Admins.
    - We gave it a Storage Admin role such that it has full access to the bucket.
    - Generate a JSON key from the bucket as you will need it in your app to give it credentials (under ```app/services/google_cloud_storage_service```) to generate URLs and so on. Active storage will also require the credentials JSON key (under ```app/services/storage.yml```) to handle the uploading of files that were not explicitly handled by direct upload for you. For the flask microservice, it can either use the same JSON key or if using a separate project, create a new service account with its respective key but I believe you will need to give that service account permission in the original project (under IAM & Admin).
    - Add this key into your project (```config/```) but under gitignore (not recommended for actual production and do not push to github or it will be disabled after a week) or use a Google's secret manager. Need this for both the Ruby app and CV Flask app if using the same key.

12. **Deploying Flask Microservice**

    - **You will need to do Steps 1, 2, 7 and 8 again if deploying the CV Flask Microservice on a separate project.** It essentially just needs to run separately but does not need its own Cloud SQL and Bucket as it does not require a database and uploads the processed video back to the original bucket.
    - Deploying it as a microservice helps as if there is a need to update the CV model to refine it etc. it can be done by reploying the microservice and not the entire Ruby app again.
    - Deploying the microservice before the Ruby app is necessary because you will need to replace the url in the Ruby app (```app/controllers/patients_controllers```) cv_assessment(form) method as it makes a http request to the microservice specified.

13. **Using the previous credentials**

    - As we attained many names / credentials in our previous steps, we need to use them in order to actually connect to them on Google Cloud. Either add them in just before and push them with your container (probably not recommended) or use Google Cloud Secret Manager but remember not to push them to github
    - Example credentials path if placed under config would be ```'config/<name_of_key>.json'```
    
    **General things to replace**
    - need to replace database, username, password and host in ```database.yml```. Host refers to ```'/cloudsql/<your_cloudsql_connection_name>'``` found under your SQL instance on Google Cloud
    - need to replace credentials path and bucket name in ```storage.yml```
    - need to replace the secret key base in the dockerfile
    - need to replace GOOGLE MAP API KEY under ```app/views/admins/client_profile.html.erb```, ```search for iframe.src = `https://www.google.com/maps/embed/v1/place?key='```. If you have not created the API Key, simply go to API & Services, search up Google Map and generate a key.
    - need to replace the credentials annd bucket name in google_cloud_storage_service.rb
    - add email credentials in ```config/environments/production.rb``` (email in gmail and password requires a 16 digit password set in your gmail account, [instructions for password](https://support.google.com/mail/answer/185833?hl=en))
    - In the same file, set config.action_mailer.perform_deliveries = true to actually send emails via the Ruby app. False will not perform mail deliveries. 
    - need to comment out the gitignore in the credentials.json file if pushing with container as the container will not be able to find files under gitignore
    - need to comment out the entire ffmpeg file in ```config/initializers/ffmpeg```. This is because this file is needed for local use but does not work in linux environment on Cloud. For Cloud, we are installing it on the container itself.
    - In cloudbuild.yaml, change the values under substitutions: to be your own values for region, project name and service name

  **Reminder not to push the above credentials onto Github or risk being compromised or having the keys disabled**

13. **Last Step**

    - if deploying for the first time, you might have to change ```bundle exec rake db:migrate``` to ```bundle exec rake db:create db:migrate db:seed``` in the apply migrations step under Cloud Build.
    - This is because the schema and seeded data on Google Cloud has not been created for the first time. Subsequently, just db:migrate is fine for any required migrations.
    - Finally, run gcloud init (if you have not done so), authenticate yourself (if required), select your project, set your region (if required), and run gcloud builds submit.

## Developer Team

Meet the amazing team behind this project.
1. [Charmaine Hong](https://www.linkedin.com/in/charmaine-hong-170554292/) | [Github@charmaineyhong](https://github.com/charmaineyhong)
2. [Celine Goh](https://www.linkedin.com/in/celineghl/) | [Github@celine-goh](https://github.com/celine-goh)
3. [Hubert Koh](https://www.linkedin.com/in/hubert-koh/) | [Github@sneakiestofbeaks](https://github.com/sneakiestofbeaks)
4. [Darrel liew](https://www.linkedin.com/in/darrel-liew-8768a321a/) | [Github@DarrelLiew](https://github.com/DarrelLiew)
5. [Royce Lim](https://www.linkedin.com/in/royce-lim-wt/) | [Github@spyabi](https://github.com/spyabi)
6. [Austin Isaac](https://www.linkedin.com/in/austin--isaac/) | [Github@Omega1424](https://github.com/Omega1424)


