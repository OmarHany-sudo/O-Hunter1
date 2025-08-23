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

# نسخ requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# نسخ الكود كله
COPY . .

# نسخ الـ build بتاع React للـ backend
COPY --from=frontend /frontend/dist ./dist

# Variables
ENV PORT=8080
ENV PYTHONPATH=/app

# Expose port
EXPOSE 8080

# Run Flask
CMD ["python", "cli.py"]
