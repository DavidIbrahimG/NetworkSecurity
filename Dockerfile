FROM python:3.10-slim

WORKDIR /app

COPY . /app

# Clean apt cache and update repositories
RUN apt-get clean && apt-get update -y && apt-get install -y \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir awscli

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8000
EXPOSE 8000

# Run the application
CMD ["python3", "app.py"]
