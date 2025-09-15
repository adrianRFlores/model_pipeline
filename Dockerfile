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

# Ensure output folder exists
RUN mkdir -p /app/data

# Run pipeline
CMD ["oxigen-pipeline", "--data-path", "/app/data/final_dataset.csv", "--target", "AQI"]
