# -------- FRONTEND --------
FROM node:20-bullseye AS frontend
WORKDIR /frontend

COPY gui/ohunter-ui/package*.json ./
RUN npm install --legacy-peer-deps

COPY gui/ohunter-ui ./

# تثبيت vite و esbuild مباشرة
RUN npm install --legacy-peer-deps vite esbuild --save-dev

# اعطاء صلاحيات تشغيل
RUN chmod -R +x node_modules/.bin node_modules/esbuild/bin node_modules/@esbuild

# بناء المشروع
RUN npx vite build

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
