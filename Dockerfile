# ============ FRONTEND ============
FROM node:18 AS frontend
WORKDIR /frontend

# copy package.json & install deps
COPY gui/ohunter-ui/package*.json ./
RUN npm install --legacy-peer-deps

# copy frontend code
COPY gui/ohunter-ui ./

# نثبت esbuild بشكل مباشر لضمان وجود الـ binary
RUN npm install --legacy-peer-deps esbuild --save-dev

# اعطي صلاحيات لكل الملفات التنفيذية
RUN chmod -R +x node_modules/.bin node_modules/esbuild/bin node_modules/@esbuild

# build project
RUN npx vite build

# -------- BACKEND --------
FROM python:3.11-slim AS backend
WORKDIR /app

# install python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy backend code
COPY core ./core
COPY modules ./modules
COPY core/scanner.py .

# copy built frontend from previous stage
COPY --from=frontend /frontend/dist ./gui/ohunter-ui/dist

# expose port
ENV PORT=8080
CMD ["python", "core/app.py"]
