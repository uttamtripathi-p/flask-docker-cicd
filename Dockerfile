# Base imag)

FROM python:3.14-slim AS builder

# Working directory

WORKDIR /app

# Copy src code to container

COPY requirements.txt .

# Run the build commands

RUN pip install -r requirements.txt --target /app/libraries

# expose port 80

EXPOSE 80

COPY . . 
