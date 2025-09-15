FROM python:3.11-slim
WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
COPY pyproject.toml .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/
COPY final_dataset.csv ./data/final_dataset.csv

RUN pip install --no-cache-dir .

CMD ["python3", "-m", "src.oxigen_pipeline", "/app/data/final_dataset.csv"]
