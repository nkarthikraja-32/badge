FROM python:3.11-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application
COPY api.py .

# Expose port (SnapDeploy uses PORT env variable, default 8000)
EXPOSE 8000

# Start with Gunicorn + Eventlet for SocketIO
CMD gunicorn --worker-class eventlet -w 1 --bind 0.0.0.0:${PORT:-8000} api:app
