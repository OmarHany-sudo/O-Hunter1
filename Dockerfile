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

# install deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy backend code
COPY . .

# copy React build to Flask static
COPY --from=frontend /frontend/dist ./gui/ohunter-ui/dist

ENV PORT=8080
ENV PYTHONPATH=/app

EXPOSE 8080

# هنا أهم حاجة: شغل app صح
CMD ["python", "core/app.py"]
