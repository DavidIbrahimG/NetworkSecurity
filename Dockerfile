# Use a minimal Python 3.10 image
FROM python:3.10-slim-buster

# Set working directory
WORKDIR /app

# Copy the application files into the container
COPY . /app

# Install pip and AWS CLI via pip
RUN pip install --no-cache-dir awscli

# Install other system dependencies via apt-get
RUN apt-get update -y && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*  # Clean up apt cache

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8000 for FastAPI or Flask apps
EXPOSE 8000

# Set the default command to run the application
CMD ["python3", "app.py"]
