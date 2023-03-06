ARG PLUGIN_VERSION="7.2.1"
ARG AIRFLOW_VERSION="2.5.1"

FROM apache/airflow:${AIRFLOW_VERSION}
ARG PLUGIN_VERSION

LABEL org.opencontainers.image.source="https://github.com/andreax79/airflow-code-editor"
LABEL org.opencontainers.image.url="https://github.com/andreax79/airflow-code-editor"
LABEL org.opencontainers.image.documentation="https://github.com/andreax79/airflow-code-editor"
LABEL org.opencontainers.image.description="Apache Airflow & Airfow Code Editor - edit DAGs in browser, file managing interface, git"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.title="Production Airflow Code Editor Image"
LABEL org.opencontainers.image.authors="Airflow Code Editor Contributors"
LABEL org.opencontainers.image.ref.name="airflow-code-editor"
LABEL org.opencontainers.image.vendor=""
LABEL org.opencontainers.image.version="${AIRFLOW_VERSION}-${PLUGIN_VERSION}"

USER root
# Install git
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         git \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
USER airflow

# Install Airflow Code Editor
COPY requirements-optional.txt .
COPY dags dags
COPY airflow_docker.cfg airflow.cfg
RUN /usr/local/bin/python -m pip install --upgrade pip
RUN pip install --no-cache-dir airflow-code-editor==${PLUGIN_VERSION} -r requirements-optional.txt && rm requirements-optional.txt