# -------- FRONTEND --------
FROM node:20 AS frontend
WORKDIR /frontend

# نسخ ملفات package.json و package-lock.json
COPY gui/ohunter-ui/package*.json ./

# تثبيت جميع dependencies مع تجاوز مشاكل peer deps
RUN npm install --legacy-peer-deps

# نسخ كل ملفات الواجهة
COPY gui/ohunter-ui ./

# تثبيت vite و esbuild بشكل مباشر للتأكد من وجود الـ binaries
RUN npm install --legacy-peer-deps esbuild vite --save-dev

# اعطاء صلاحيات تنفيذ لكل الـ binaries
RUN chmod -R +x node_modules/.bin node_modules/esbuild/bin node_modules/@esbuild

# بناء المشروع
RUN npx vite build

# -------- BACKEND --------
FROM python:3.11-slim AS backend
WORKDIR /app

# نسخ requirements وتثبيت المكتبات
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# نسخ الكود
COPY core ./core
COPY modules ./modules
COPY core/scanner.py .

# نسخ build الواجهة من مرحلة الـ frontend
COPY --from=frontend /frontend/dist ./gui/ohunter-ui/dist

# تعيين المنفذ
ENV PORT=8080

# تشغيل السيرفر
CMD ["python", "core/app.py"]

