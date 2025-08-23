FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system deps + node + pnpm
RUN apt-get update && apt-get install -y curl gnupg \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pnpm \
    && rm -rf /var/lib/apt/lists/*

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

# ===== Build Frontend =====
WORKDIR /app/gui/ohunter-ui
RUN pnpm install && pnpm run build

# Back to backend
WORKDIR /app

# Env vars
ENV PYTHONPATH=/app
ENV PORT=8080

# Expose port
EXPOSE $PORT

# Run Flask app
CMD ["python", "-m", "core.app"]
