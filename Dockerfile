FROM python:3.10-slim-buster

# Set working directory
WORKDIR /app

# Copy all the application files into the container
COPY . /app

# Install system dependencies, including AWS CLI
RUN apt-get update -y && apt-get install -y \
    awscli \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*  # Clean up apt cache to reduce image size

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose the application port (useful for FastAPI or Flask)
EXPOSE 8000

# Command to run the application
CMD ["python3", "app.py"]
