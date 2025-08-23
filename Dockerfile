# -------- FRONTEND --------
FROM node:20-bullseye AS frontend
WORKDIR /frontend

# انسخ ملفات الـ package
COPY gui/ohunter-ui/package*.json ./

# ثبت كل الـ dependencies بدون مشاكل peer
RUN npm install --legacy-peer-deps

# انسخ باقي ملفات المشروع
COPY gui/ohunter-ui ./

# ثبت vite و esbuild محليًا
RUN npm install vite esbuild --legacy-peer-deps

# build المشروع
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
