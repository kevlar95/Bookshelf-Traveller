# official Python runtime as a base image
FROM python:3.11-slim

# Use an official MongoDB runtime as a base image
# FROM mongo:latest

# Set the working directory to /AudiblePy
WORKDIR /ABSBOT

# Copy the current directory contents into the container at /app
COPY Scripts/main.py /ABSBOT
COPY Scripts/Bookshelf.py /ABSBOT
COPY Scripts/requirements.txt /ABSBOT
COPY Scripts/settings.py /ABSBOT

# Update OS
RUN set -ex \
    && apt-get update \
    && apt-get upgrade -y

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Clean up
RUN set -ex apt-get autoremove -y \\
    && apt-get clean -y \\
    && rm -rf /var/lib/apt/lists/*

CMD ["python", "main.py"]
