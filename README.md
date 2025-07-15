# Network Security Project: Phishing Detection

## Project Overview

This project aims to develop a machine learning model to **predict phishing websites** using a set of domain and URL-related features. The model is built in an **end-to-end pipeline** that involves multiple stages, from data ingestion to deployment. Below is a detailed breakdown of each step involved in the project.

### **Key Steps in the Pipeline:**

1. **Data Ingestion from MongoDB Atlas**:
   - The raw data is initially stored in **MongoDB Atlas**.
   - The data is **pulled from MongoDB** using the **PyMongo** library and ingested into the pipeline for further processing.

2. **Data Transformation and Feature Engineering**:
   - **Data Transformation**: The ingested data undergoes transformations like cleaning, feature extraction, and feature engineering.
   - **Feature Engineering**: New features were created based on domain characteristics and URL behavior. This step is crucial for improving the accuracy of machine learning models.

3. **Data Validation**: The data is validated to ensure no anomalies or missing values before it is passed to the training phase.

4. **Model Training**:
   - The model was trained using machine learning algorithms such as **Logistic Regression**, **Random Forest**, or **XGBoost** to classify URLs and domains as either **phishing** (malicious) or **legitimate**.
   - Hyperparameter tuning was performed using **GridSearchCV** or **RandomizedSearchCV** to find the best model parameters.
   - The model was evaluated using various performance metrics such as **accuracy**, **precision**, **recall**, and **F1-score**.

5. **Experiment Tracking with MLflow and Dagshub**:
   - **Dagshub** is used for **experiment tracking**: This includes keeping track of model versions, hyperparameters, and metrics.
   - **MLflow** is used to track and log models, metrics, and artifacts. The model and metrics are logged to **Dagshub** for versioning, and **MLflow** is used to keep track of performance metrics.

6. **FastAPI Integration for Real-Time Predictions**:
   - Once the model was trained, it was integrated with **FastAPI** to expose the model as an **API endpoint**.
   - The FastAPI server is responsible for handling incoming requests and providing predictions on whether a URL is phishing or legitimate based on the trained model.
   - The API can accept new URL data and return a prediction, making it easy for integration into a larger system.

7. **Dockerization**:
   - The entire model, FastAPI server, and necessary dependencies were containerized using **Docker**.
   - A Docker image was built for the application, allowing for easier deployment and scalability.
   - The image was stored in **Amazon Elastic Container Registry (ECR)** for easy management and version control of Docker images.

8. **AWS ECR and EC2 Deployment**:
   - The Docker image was pushed to **Amazon Elastic Container Registry (ECR)**, where it was stored and versioned.
   - The Docker image was then pulled from **ECR** and deployed to an **AWS EC2 instance** for serving the application in a production environment.

9. **CI/CD with GitHub Actions**:
   - **GitHub Actions** was used to automate the entire process, from data ingestion, model training, to Docker image building, pushing to ECR, and deploying the application to EC2.
   - This pipeline ensured that any updates to the repository are automatically tested, built, and deployed.

## Dataset Features

This project uses a variety of **URL and domain features** to predict phishing sites. The dataset includes columns such as:

- **having_IP_Address**: Whether the URL contains an IP address instead of a domain name.
- **URL_Length**: The length of the URL; phishing sites often use long URLs to confuse users.
- **Shortining_Service**: Whether a URL shortening service is used.
- **having_At_Symbol**: Presence of the "@" symbol, which is often used in phishing URLs.
- **double_slash_redirecting**: The URL has multiple slashes or redirection techniques.
- **Prefix_Suffix**: Presence of prefixes and suffixes, common in phishing attempts.
- **having_Sub_Domain**: Whether the URL contains a subdomain. Phishing sites often use subdomains to appear like legitimate websites.
- **SSLfinal_State**: The SSL certification status of the website (e.g., whether it uses HTTPS).
- **Domain_registration_length**: The length of time the domain has been registered. Phishing sites often use newly registered domains.
- **Favicon**: Whether the website has a favicon, a feature often missing in phishing sites.
- **port**: The port used by the website; phishing sites may use non-standard ports.
- **HTTPS_token**: Indicates if the website uses HTTPS (secure connection).
- **Request_URL**: URL requested by the website. Phishing sites often have unusual requests.
- **URL_of_Anchor**: Whether the URL is linked to other anchors, which may be suspicious.
- **Links_in_tags**: Whether the page contains multiple links in HTML tags.
- **SFH**: Whether the page uses a **Submit Form Handler**, which is common in phishing forms.
- **Submitting_to_email**: Indicates whether the form submits data to an email address, a typical phishing method.
- **Abnormal_URL**: Indicates if the URL is abnormal or suspicious.
- **Redirect**: Whether the website performs redirection, a technique often used by phishing sites.
- **on_mouseover**: Use of JavaScript events like mouseover, commonly found in phishing sites.
- **RightClick**: Whether right-click is disabled on the page, often done in phishing sites.
- **PopUpWindow**: Whether the site opens a popup window.
- **Iframe**: Presence of **iframe** elements, used by phishing sites to load malicious content.
- **age_of_domain**: The age of the domain; phishing sites often use newly created domains.
- **DNSRecord**: The validity of DNS records for the domain.
- **web_traffic**: Amount of web traffic the site receives, typically lower for phishing sites.
- **Page_Rank**: The PageRank of the website, lower for phishing sites.
- **Google_Index**: Whether the website is indexed by Google.
- **Links_pointing_to_page**: The number of backlinks to the site.
- **Statistical_report**: Various statistical data points about the website, such as traffic, load times, etc.
- **Result**: Whether the website is phishing (1) or legitimate (0).

## Technologies Used

- **Python**: Main programming language for the pipeline.
- **MongoDB Atlas**: Cloud-hosted NoSQL database for storing data.
- **FastAPI**: Framework for building and exposing APIs.
- **Docker**: Containerization of the model and FastAPI server.
- **AWS ECR**: Storage for Docker images.
- **AWS EC2**: Deployment of the application.
- **MLflow**: Experiment tracking and model versioning.
- **Dagshub**: Version control and experiment tracking.
- **GitHub Actions**: CI/CD automation for the entire pipeline.

## Setup Instructions

### 1. **Clone the Repository**

    git clone https://github.com/yourusername/your-repository.git
    cd your-repository


### 2. **Install Dependencies**
    pip install -r requirements.txt

### 3. **Setup Github Actions**
    AWS_ACCESS_KEY_ID

    AWS_SECRET_ACCESS_KEY

    AWS_REGION

    AWS_ACCOUNT_ID

    ECR_REPOSITORY_NAME (The name of your repository in ECR)
### 4. **Run the Application Locally (FastAPI)**
    uvicorn app:app --reload

### 5. Run Docker Locally
    docker build -t my-image-name .
    docker run -d -p 8000:8000 my-image-name

### 6. Docker Setup in EC2

To run Docker on your AWS EC2 instance, follow these steps to set it up:

#### Optional (Run these commands to update the system):
    sudo apt-get update -y
    sudo apt-get upgrade -y

#### Required (Install Docker on EC2):
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh

#### Add the ubuntu user to the Docker group:
    sudo usermod -aG docker ubuntu

#### Apply the changes (to avoid logout/login):
    newgrp docker


