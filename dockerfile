# Use an official Python base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy files
COPY app.py .

# Install Flask
RUN pip install flask

# Expose port
EXPOSE 5000

# Command to run the app
CMD ["python", "app.py"]
