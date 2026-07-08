# Immagine per KidsPlay Web Arcade: http.server Python (statico) con monitoring.
# Il server (src/backend/server.py) serve i file da src/frontend sulla porta 8080.
FROM python:3.12-slim

WORKDIR /app

COPY src/backend/requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8080

CMD ["python", "src/backend/server.py"]
