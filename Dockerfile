# Use Python base image
FROM python:3.12

# Set the working directory in the container
WORKDIR /base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    apt-utils \
    wget \
    gnupg2 \
    apt-transport-https \
    software-properties-common \
    libgtk2.0-0 \
    libcanberra-gtk-module \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install poetry

# Copy the project files into the container
COPY . .

# Install project dependencies (including Jupyter) once the container is running
# This will not run automatically until you execute it after the container starts
# RUN if [ -f pyproject.toml ]; then poetry install --no-root; fi

# Expose port for Jupyter (if you plan to run it later)
EXPOSE 8888

# Default command (you can change this to a shell or other command)
CMD ["bash", "--port=8888", "--allow-root"]