# ============ Build React Frontend ============
FROM node:18 AS frontend
WORKDIR /frontend

# انسخ بس package.json والـ lockfile
COPY gui/ohunter-ui/package*.json ./

# نزّل dependecies + vite
RUN npm install --legacy-peer-deps vite

# انسخ باقي الكود
COPY gui/ohunter-ui ./

# ابني المشروع
RUN npm run build



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
