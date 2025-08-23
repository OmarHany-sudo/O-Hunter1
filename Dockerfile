# -------- FRONTEND --------
FROM node:20-bullseye AS frontend
WORKDIR /frontend

# انسخ الـ package.json و package-lock.json
COPY gui/ohunter-ui/package*.json ./

# ثبت dependencies مع تجاهل peer conflicts
RUN npm install --legacy-peer-deps

# انسخ باقي ملفات المشروع
COPY gui/ohunter-ui ./

# build project بدون rebuild esbuild أو chmod
RUN npx vite build --force


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
