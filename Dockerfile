# -------- FRONTEND --------
FROM node:20 AS frontend
WORKDIR /frontend

# انسخ package.json و package-lock.json لو موجود
COPY gui/ohunter-ui/package*.json ./

# امسح أي تثبيت قديم وثبت الباكجات
RUN rm -rf node_modules package-lock.json \
    && npm install --legacy-peer-deps \
    && npm install vite esbuild --legacy-peer-deps

# انسخ باقي ملفات المشروع
COPY gui/ohunter-ui ./

# اعطي صلاحيات execute للـ binaries
RUN chmod -R +x node_modules/.bin node_modules/vite node_modules/esbuild/bin node_modules/@esbuild

# اعمل build للـ frontend
RUN npx vite build

# -------- BACKEND --------
FROM python:3.11-slim AS backend
WORKDIR /app

# انسخ requirements.txt وثبت الباكجات
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# انسخ باقي ملفات الـ backend
COPY core ./core
COPY modules ./modules
COPY core/scanner.py .

# انسخ الـ frontend المبني من المرحلة السابقة
COPY --from=frontend /frontend/dist ./gui/ohunter-ui/dist

# expose port
ENV PORT=8080
CMD ["python", "core/app.py"]
