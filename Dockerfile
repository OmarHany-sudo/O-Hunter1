# -------- FRONTEND --------
FROM node:20 AS frontend
WORKDIR /frontend

# انسخ package.json و package-lock.json لو موجود
COPY gui/ohunter-ui/package*.json ./

# امسح أي تثبيت قديم
RUN rm -rf node_modules package-lock.json \
    && npm install --legacy-peer-deps \
    && npm install vite esbuild --legacy-peer-deps

# انسخ باقي ملفات المشروع
COPY gui/ohunter-ui ./

# اعطي صلاحيات execute للـ binaries
RUN chmod -R +x node_modules/.bin node_modules/vite node_modules/esbuild/bin node_modules/@esbuild

# اعمل build للمشروع
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
