# ============================================================
# STAGE 1 — Builder
# Full Python image so we have pip and build tools available
# ============================================================

# Pull official Python 3.11 slim image as our build environment
# 'slim' has pip and basic tools but is smaller than the full image
FROM python:3.11-slim AS builder

# Set /app as our working directory inside the container
# All subsequent commands run from here
WORKDIR /app

# Copy requirements.txt first (before rest of code)
# Docker caches this layer — pip install won't re-run unless requirements.txt changes
COPY requirements.txt .

# Install dependencies into /app/libraries instead of system Python
# --target keeps them isolated and easy to copy into the next stage
RUN pip install --target=/app/libraries -r requirements.txt

# Now copy the rest of your application source code
# Done AFTER pip install so code changes don't invalidate the pip cache layer
COPY . .


# ============================================================
# STAGE 2 — Final image
# Distroless = no shell, no package manager, minimal attack surface
# Only contains Python runtime and your app — nothing else
# ============================================================

# Start fresh from a minimal distroless Python image
# Nothing from builder carries over except what we explicitly COPY
FROM gcr.io/distroless/python3

# Set working directory in the final image
WORKDIR /app

# Copy everything from builder's /app into this stage's /app
# This includes your source code AND the installed libraries
COPY --from=builder /app .

# Tell Python where to find the installed libraries
# Since we installed to /app/libraries, Python needs to know to look there
ENV PYTHONPATH=/app/libraries

# Document that the container listens on port 80
# This is metadata only — does NOT actually open the port (docker run -p does that)
EXPOSE 80

# Command to run when container starts
# Distroless already sets python as entrypoint, so just pass the script name
# Cannot use "python run.py" here — distroless has no shell to parse that
CMD ["run.py"]
