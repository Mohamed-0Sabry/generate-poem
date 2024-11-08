# Use the official Python 3.10.11 image
FROM python:3.10.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set the working directory to the root
WORKDIR /

# Copy requirements.txt to the root directory
COPY requirements.txt /

# Add dependencies for building camel-kenlm
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libkenlm-dev

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt


# Copy the application files to the root directory
COPY . /

# Expose port (optional, based on your FastAPI settings)
EXPOSE 8000

# Command to run the FastAPI app (adjust as needed)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
