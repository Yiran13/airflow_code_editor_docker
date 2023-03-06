
## Step0:
docker build . -f Dockerfile --tag airflow:with_code_editor

## Step1:
mkdir -p ./dags ./logs ./plugins
echo -e "AIRFLOW_UID=$(id -u)" > .env

## Step2
docker compose up airflow-init

## Step3
docker-compose up -d