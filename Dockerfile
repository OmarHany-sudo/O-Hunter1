# -------- FRONTEND --------
FROM node:20-bullseye AS frontend
WORKDIR /frontend

COPY gui/ohunter-ui/package*.json ./
RUN npm install --legacy-peer-deps

COPY gui/ohunter-ui ./

# rebuild esbuild للـ linux
RUN npm rebuild esbuild

# build project
RUN npx --yes vite build --force


# -------- BACKEND --------
FROM python:3.11-slim AS backend
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY core ./core
COPY modules ./modules
COPY core/scanner.py .

COPY --from=frontend /frontend/dist ./gui/ohunter-ui/dist

ENV PORT=8080
CMD ["python", "core/app.py"]
