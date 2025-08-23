# ============ Build React Frontend ============
FROM node:18 AS frontend
WORKDIR /frontend
COPY gui/ohunter-ui/package*.json ./
RUN npm install
COPY gui/ohunter-ui ./
RUN npm run build

# ============ Build Python Backend ============
FROM python:3.11-slim AS backend
WORKDIR /app

# Install deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend code
COPY . .

# نسخ الـ React build جوه الـ static folder اللي Flask بيشاور عليه
COPY --from=frontend /frontend/dist ./gui/ohunter-ui/dist

# Vars
ENV PORT=8080
ENV PYTHONPATH=/app

EXPOSE 8080

# Run Flask (خليها cli.py لأن الكود اللي وريتهولي جوا cli.py)
CMD ["python", "cli.py"]
