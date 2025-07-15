# Use a slim Python 3.10 base image
FROM python:3.10-slim-buster

# Set the working directory inside the container
WORKDIR /app

# Copy all application files to the container
COPY . /app

# Install system dependencies (curl, unzip, awscli)
RUN apt-get update -y && apt-get install -y \
    curl \
    unzip \
    awscli

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8000 for FastAPI app
EXPOSE 8000

# Set the default command to run the application
CMD ["python3", "app.py"]
